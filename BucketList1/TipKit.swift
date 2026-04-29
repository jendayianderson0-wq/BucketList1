//
//  TipKit.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/29/26.
//

import TipKit

struct TrophyTip: Tip {

    @Parameter
    static var hasCompletedOnboarding: Bool = false

    var title: Text {
        Text("Your Achievements")
    }
    var message: Text? {
        Text("Tap the trophy to see all your earned badges and progress.")
     
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
