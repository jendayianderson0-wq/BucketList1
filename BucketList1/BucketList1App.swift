//
//  BucketList1App.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/9/26.
//

import SwiftUI
import TipKit
import Combine


class images: ObservableObject {
        
    
   @Published var collection:[UIImage] = []
}

@main
struct BucketList1App: App {
    init() {
        
        try? Tips.configure()
    }
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = true
    
    @StateObject var imageCollection = images()

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                NotebookView()
                    .environmentObject(imageCollection)
                        } else {
                            InterestPageView(onComplete: {
                                hasCompletedOnboarding = true
                            }).environmentObject(imageCollection)
                        }
                    }
               //     .modelContainer(for: BucketItem.self)
                }
            }
