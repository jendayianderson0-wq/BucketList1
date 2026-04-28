//
//  BucketList1App.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/9/26.
//

import SwiftUI
import TipKit

@main
struct BucketList1App: App {
    init() {
        
        try? Tips.configure()
    }
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = true

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                NotebookView()
                        } else {
                            InterestPageView(onComplete: {
                                hasCompletedOnboarding = true
                            })
                        }
                    }
               //     .modelContainer(for: BucketItem.self)
                }
            }
