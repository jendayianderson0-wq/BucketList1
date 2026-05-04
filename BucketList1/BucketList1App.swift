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
    //storage for tip kit
    init() {
        //try? stops the crashing "attmept this but if it fails kist ignore the error 
      //  try? Tips.resetDatastore()
        try? Tips.configure([
            .displayFrequency(.immediate),
            .datastoreLocation(.applicationDefault)
        ])
    }
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

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
