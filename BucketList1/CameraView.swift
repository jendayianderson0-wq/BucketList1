//
//  CameraView.swift
//  BucketList
//
//  Created by Charlotte Robinson on 4/6/26.
//

import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
            @Binding var image: UIImage?// bind to the parent view state
            @Environment(\.presentationMode) var presentationMode// dismiss the view
            func makeUIViewController(context: Context) -> UIImagePickerController {
                let picker = UIImagePickerController()
                picker.delegate = context.coordinator// set the coordinator as delegate
                picker.sourceType = .camera// set the source to cam
                return picker
            }
            func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
                
            }
            func makeCoordinator() -> Coordinator {
                Coordinator(self)
            }
            
            class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
                let parent: CameraView
                
                init(_ parent: CameraView){
                    self.parent = parent
                }
                func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
                    if let image = info[.originalImage] as? UIImage{
                        parent.image = image// pass the selected iamge
                    }
                    parent.presentationMode.wrappedValue.dismiss()
                        
                }
                func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                    parent.presentationMode.wrappedValue.dismiss()// dismiss cam
                }
            }
            
            
            
        }
