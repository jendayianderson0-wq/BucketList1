//
//  PhotoGridView.swift
//  BucketList
//
//  Created by Charlotte Robinson on 4/6/26.
//

import SwiftUI
import PhotosUI

struct YearbookView: View {
    struct YearbookEntry: Codable {
        var path: String
        var caption: String?
    }

    @AppStorage("savedYearbookEntries") var savedEntriesData: Data = Data()
    @State private var images: [UIImage] = []
    @State private var pickerItems: [PhotosPickerItem] = []
    @State private var isEditing = false
    @State private var fullscreenPhoto: FullscreenPhoto? = nil

    // MARK: - Saved Paths Helpers
    var savedEntries: [YearbookEntry] {
        (try? JSONDecoder().decode([YearbookEntry].self, from: savedEntriesData)) ?? []
    }
    func updateEntries(_ entries: [YearbookEntry]) {
        savedEntriesData = (try? JSONEncoder().encode(entries)) ?? Data()
    }

    // MARK: - Image Helpers
    func saveImage(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("yearbook_\(UUID().uuidString).jpg")
        try? data.write(to: path)
        return path.path
    }

    func loadImages() {
        images = savedEntries.compactMap { entry in
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: entry.path)) else { return nil }
            return UIImage(data: data)
        }
    }

    func deleteImage(at index: Int) {
        var entries = savedEntries
        guard index < entries.count else { return }
        try? FileManager.default.removeItem(atPath: entries[index].path)
        images.remove(at: index)
        entries.remove(at: index)
        updateEntries(entries)
    }

   

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {

                // ── Header ──
                ZStack(alignment: .topTrailing) {
                    VStack {
                        HStack {
                            Image(systemName: "star.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.yellow)
                                .rotationEffect(.degrees(60))
                                .offset(y: -20)
                            Image(systemName: "star.fill")
                                .font(.system(size: 28))
                                .foregroundStyle(.purple)
                                .rotationEffect(.degrees(90))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 16)

                        // Title
                        Text("Yearbook")
                            .foregroundColor(.red)
                            .font(.custom("Soopafresh", size: 50))
                            .fontWeight(.bold)
//                            .frame(maxWidth: .infinity, alignment: .center)
                    }

                    // Edit button top right
                    Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                    .foregroundColor(.red)
                    .padding(.trailing, 16)
                    .padding(.top, 60)
                }

                // ── Photo Grid ──
                ScrollView {
                    PinterestGrid(
                        images: images,
                        isEditing: isEditing,
                        onDelete: deleteImage,
                        onTap: { img, idx in
                            let caption = (idx < savedEntries.count) ? savedEntries[idx].caption : nil
                            fullscreenPhoto = FullscreenPhoto(image: img, caption: caption)
                        }
                    )
                    .padding(.horizontal, 12)
                    .padding(.bottom, 80) // space so last photo isn't behind picker button
                }
            }

            // ── Photo Picker Button (bottom right) ──
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .images) {
                Image(systemName: "photo.on.rectangle")
                    .foregroundColor(.red)
                    .font(.system(size: 25))
                    .padding(20)
            }
        }
        .onAppear { loadImages() }
        .onChange(of:savedEntriesData) { _ in
            loadImages()
        }
        .onChange(of: pickerItems) { _ in
            Task {
                var entries = savedEntries
                for item in pickerItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let img = UIImage(data: data),
                       let path = saveImage(img) {
                        images.append(img)
                        entries.append(YearbookEntry(path: path, caption: nil))
                    }
                }
                updateEntries(entries)
                pickerItems = []
            }
        }
        .fullScreenCover(item: $fullscreenPhoto) { photo in
            FullscreenView(image: photo.image, caption: photo.caption)
        }
    }
}

// MARK: - Pinterest Grid
struct PinterestGrid: View {
    let images: [UIImage]
    let isEditing: Bool
    let onDelete: (Int) -> Void
    let onTap: (UIImage, Int) -> Void

    var body: some View {
        let leftImages  = images.enumerated().filter { $0.offset % 2 == 0 }
        let rightImages = images.enumerated().filter { $0.offset % 2 == 1 }

        HStack(alignment: .top, spacing: 10) {
            VStack(spacing: 10) {
                ForEach(leftImages, id: \.offset) { item in
                    PhotoCard(image: item.element, index: item.offset, isEditing: isEditing, onDelete: onDelete, onTap: onTap)
                }
            }
            VStack(spacing: 10) {
                ForEach(rightImages, id: \.offset) { item in
                    PhotoCard(image: item.element, index: item.offset, isEditing: isEditing, onDelete: onDelete, onTap: onTap)
                }
            }
        }
    }
}

// MARK: - Photo Card
struct PhotoCard: View {
    let image: UIImage
    let index: Int
    let isEditing: Bool
    let onDelete: (Int) -> Void
    let onTap: (UIImage, Int) -> Void

    var cardHeight: CGFloat {
        let ratio = image.size.height / image.size.width
        let baseWidth = (UIScreen.main.bounds.width - 34) / 2
        return min(max(baseWidth * ratio, 120), 320)
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .contentShape(RoundedRectangle(cornerRadius: 16))
                .onTapGesture {
                    if !isEditing { onTap(image, index) }
                }

            if isEditing {
                Button { onDelete(index) } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.white, .red)
                        .font(.system(size: 22))
                        .padding(6)
                }
            }
        }
    }
}

// MARK: - Fullscreen Viewer
struct FullscreenPhoto: Identifiable {
    let id = UUID()
    let image: UIImage
    let caption: String?
}

struct FullscreenView: View {
    let image: UIImage
    let caption: String?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            
            if let caption, !caption.isEmpty {
                Text(caption)
                    .font(.system(size: 15))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(16)
            }
            
            Button { dismiss() } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.white, .gray)
                    .font(.system(size: 30))
                    .padding()
            }
        }
    }
}

#Preview {
    YearbookView()
}
