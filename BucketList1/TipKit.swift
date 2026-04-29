//
//  TipKit.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/29/26.
//

import TipKit

// ── Trophy Tip (Homeroom page)
struct TrophyTip: Tip {

    @Parameter
    static var hasCompletedOnboarding: Bool = false

    var title: Text {
        Text("Your Achievements")           // ← your title
    }
    var message: Text? {
        Text("Tap the trophy to see all your earned badges and progress.")
        // ← your message
    }
    var image: Image? {
        Image(systemName: "trophy.fill")
    }
    var rules: [Rule] {
        [
            #Rule(Self.$hasCompletedOnboarding) { $0 == true }
        ]
    }
}

// ── Adventure List Tip (Homeroom page)
struct AdventureListTip: Tip {

    @Parameter
    static var hasCompletedOnboarding: Bool = false

    var title: Text {
        Text("Your Adventure List")         // ← your title
    }
    var message: Text? {
        Text("These are weekly challenges picked just for you. Tap to see them all.")
        // ← your message
    }
    var image: Image? {
        Image(systemName: "list.star")
    }
    var rules: [Rule] {
        [
            #Rule(Self.$hasCompletedOnboarding) { $0 == true }
        ]
    }
}
