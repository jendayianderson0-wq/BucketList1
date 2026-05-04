//
//  PhotoGridView.swift
//  BucketList
//
//  Created by Charlotte Robinson on 4/6/26.
//

import SwiftUI
import PhotosUI
import SwiftData




// MARK: - Identifiable Image Wrapper
struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: UIImage
}

// MARK: - Full Screen Image Viewer
struct FullScreenImageView: View {
    let image: UIImage
    @Environment(\.dismiss) var dismiss
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in scale = max(1.0, value) }
                        .onEnded { _ in
                            withAnimation(.spring()) { scale = 1.0 }
                        }
                )
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.white, .gray)
                    .font(.system(size: 30))
                    .padding()
            }
        }
    }
}

// MARK: - Yearbook View
struct YearbookView: View {
    @AppStorage("savedImagePaths") var savedImagePathsData: Data = Data()
    
    @State private var selectedItem: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @State private var showingCamera = false
    @State private var isEditing = false
    @State private var tappedImage: IdentifiableImage? = nil
    
    let columns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]
    
    // MARK: - Persistence Helpers
    var savedPaths: [String] {
        (try? JSONDecoder().decode([String].self, from: savedImagePathsData)) ?? []
    }
    
    func savePaths(_ paths: [String]) {
        savedImagePathsData = (try? JSONEncoder().encode(paths)) ?? Data()
    }
    
    func saveImage(_ image: UIImage, name: String) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(name)
        try? data.write(to: url)
        return url.path
    }
    
    func loadAllImages() {
        selectedImages = savedPaths.compactMap { path in
            let url = URL(fileURLWithPath: path)
            guard let data = try? Data(contentsOf: url) else { return nil }
            return UIImage(data: data)
        }
    }
    
    func deleteImage(at index: Int) {
        let paths = savedPaths
        guard index < paths.count else { return }
        let url = URL(fileURLWithPath: paths[index])
        try? FileManager.default.removeItem(at: url)
        selectedImages.remove(at: index)
        var updatedPaths = paths
        updatedPaths.remove(at: index)
        savePaths(updatedPaths)
    }
    
    // MARK: - Body
    var body: some View {
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
        
        VStack {
            Text("Yearbook")
                .foregroundColor(.red)
                .font(.custom("Soopafresh", size: 50))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(0..<selectedImages.count, id: \.self) { index in
                        ZStack(alignment: .topLeading) {
                            Image(uiImage: selectedImages[index])
                                .resizable()
                                .scaledToFill()
                                .frame(height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .onTapGesture {
                                    if !isEditing {
                                        tappedImage = IdentifiableImage(image: selectedImages[index])
                                    }
                                }
                            
                            if isEditing {
                                Button {
                                    deleteImage(at: index)
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.white, .red)
                                        .font(.system(size: 22))
                                        .padding(6)
                                }
                            }
                        }
                    }
                }
                .padding(16)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                    .foregroundColor(.red)
                }
            }
            
            VStack {
                PhotosPicker(selection: $selectedItem,
                             maxSelectionCount: 10,
                             matching: .images) {
                    Image(systemName: "photo.on.rectangle")
                        .foregroundColor(.red)
                        .font(.system(size: 25))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
        }
        .sheet(item: $tappedImage) { identifiable in
            FullScreenImageView(image: identifiable.image)
        }
        .onAppear {
            loadAllImages()
        }
        .onChange(of: selectedItem) { _ in
            Task {
                var newPaths = savedPaths
                for item in selectedItem {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImages.append(uiImage)
                        let name = "yearbook_\(UUID().uuidString).jpg"
                        if let path = saveImage(uiImage, name: name) {
                            newPaths.append(path)
                        }
                    }
                }
                savePaths(newPaths)
            }
        }
    }
}

#Preview {
    YearbookView()
}
