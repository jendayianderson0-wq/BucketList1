//
//  DetailView.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/15/26.
//

import SwiftUI
import PhotosUI

struct DetailView: View {
    @Binding var item: BucketItem
    @State private var uploadedImage: Image? = nil
    @State private var photoItem: PhotosPickerItem? = nil
 
    // "Complete task" is only active once a photo is uploaded
    var canComplete: Bool { uploadedImage != nil }
 
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
 
                ZStack(){
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
 
                    VStack {
                        Text(item.task)
                            .font(.system(size: 22, weight: .bold))
                            .multilineTextAlignment(.center)
                            .padding(20)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
 
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.system(size: 16, weight: .bold))
                    Text(item.description)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.primary)
                }
                .padding(.horizontal, 20)
 
                // Uploaded photo preview (appears after picking)
                if let uploadedImage {
                    uploadedImage
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal, 20)
                }
 
                HStack(spacing: 12) {
                    // Add to Yearbook 
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        Label("Add to Yearbook", systemImage: "camera.fill")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.redd)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
 
                    //only is completed when a photo is added
                    Button {
                        item.isCompleted = true
                    } label: {
                        Label("Completed task", systemImage: "play.fill")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(canComplete ? Color.redd : Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .disabled(!canComplete)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
        }
        .background(
        Image("crumple")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
             )
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Details")
                    .font(.custom("soopafresh", size: 40))
                    .foregroundStyle(Color.redd)
            }
        }
        
        // Load the picked photo into uploadedImage
        .onChange(of: photoItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    uploadedImage = Image(uiImage: uiImage)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var previewItem = BucketItem(
        task: "Task",
        description: " description",
        linkedInterest: "",
        isCompleted: false
    )

    return NavigationView {
        DetailView(item: $previewItem)
    }
}
