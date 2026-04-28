//
//  DetailView.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/15/26.
//

import SwiftUI
import PhotosUI

struct ConfettiPiece: View {
    let index: Int
    @State private var animate = false

    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]

    var body: some View {
        Circle()
            .fill(colors[index % colors.count])
            .frame(width: 10, height: 10)
            .offset(
                x: animate ? CGFloat.random(in: -180...180) : 0,
                y: animate ? CGFloat.random(in: -400...100) : 0
            )
            .opacity(animate ? 0 : 1)
            .onAppear {
                withAnimation(
                    .easeOut(duration: 1.2)
                    .delay(Double(index) * 0.04)
                ) {
                    animate = true
                }
            }
    }
}

struct DetailView: View {
    @Binding var item: BucketItem
    @State private var uploadedImage: Image? = nil
    @State private var photoItem: PhotosPickerItem? = nil
    @State private var showCelebration = false
 
    // "Complete task" is only active once a photo is uploaded
    var canComplete: Bool { uploadedImage != nil }
 
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
 
                ZStack(){
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
                        .overlay (
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black.opacity(0.30), lineWidth: 1)
                )
 
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
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                    )
                
                .shadow(color: .black.opacity(0.30), radius: 6, x: 0, y: 3)
                .padding(.horizontal,20)
 
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
                        // 2. unwrap photoItem
                            // 2.5 set item.image == unwrappedPhotoItem
                        // 3. Handle the nil value (if a photoItem isn't selected
                        item.isCompleted = true
                        showCelebration = true
                    } label: {
                        Label("Completed task", systemImage: "checkmark.circle.fill")
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
        //add a part for if the photo is not available for the user. 
        .overlay {
            if showCelebration {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture { showCelebration = false }

                    VStack(spacing: 16) {
                        Text("🎉")
                            .font(.system(size: 60))

                        Text("Good Job!")
                            .font(.custom("soopafresh", size: 36))
                            .foregroundStyle(Color.redd)

                        Text("You completed this task!")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.gray)
                    }
                    .padding(32)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 20)
                    .padding(.horizontal, 40)

                    // Confetti pieces
                    ForEach(0..<20, id: \.self) { i in
                        ConfettiPiece(index: i)
                    }
                }
                .transition(.opacity)
                .animation(.easeInOut, value: showCelebration)
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
