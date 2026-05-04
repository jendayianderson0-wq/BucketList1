//
//  AchievementsView.swift
//  BucketList
//
//  Created by Charlotte Robinson on 4/12/26.
//

import SwiftUI
import PhotosUI




struct AchievementsView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var stickerImage: UIImage?
    struct Achievement: Identifiable {
        let id: String
        let imageName: String
        let requirement: String
        var isUnlocked: Bool
    }
    
    @State private var achievements: [Achievement] = [
        Achievement(id: "trophy",      imageName: "trophy",      requirement: "Reach #1 on the leaderboard",       isUnlocked: false),
        Achievement(id: "rocket",      imageName: "rocket",      requirement: "Complete your first lesson",        isUnlocked: true),
        Achievement(id: "popcorn",     imageName: "popcorn",     requirement: "Complete 5 lessons in a row",       isUnlocked: false),
        Achievement(id: "diamond",     imageName: "diamond",     requirement: "Earn 1000 points",                  isUnlocked: false),
        Achievement(id: "pencil",      imageName: "pencil",      requirement: "Write 10 notes",                    isUnlocked: false),
        Achievement(id: "target",      imageName: "target",      requirement: "Get 100% on any quiz",              isUnlocked: true),
        Achievement(id: "flag",        imageName: "flag",        requirement: "Complete your first milestone",     isUnlocked: false),
        Achievement(id: "notebook",    imageName: "notebook",    requirement: "Read 20 articles",                  isUnlocked: false),
        Achievement(id: "bulb",        imageName: "bulb",        requirement: "Answer 50 questions correctly",     isUnlocked: false),
        Achievement(id: "mic",         imageName: "mic",         requirement: "Submit your first presentation",    isUnlocked: false),
        Achievement(id: "spaceship",   imageName: "spaceship",   requirement: "Explore all app sections",          isUnlocked: false),
        Achievement(id: "meteor",      imageName: "meteor",      requirement: "Level up 3 times in one week",      isUnlocked: false),
        Achievement(id: "firecracker", imageName: "firecracker", requirement: "Invite 3 friends",                  isUnlocked: false),
        Achievement(id: "bomb",        imageName: "bomb",        requirement: "Finish a course in under 1 hour",   isUnlocked: false),
        Achievement(id: "fire",        imageName: "fire",        requirement: "Maintain a 7-day streak",           isUnlocked: false),
        Achievement(id: "gradcap",     imageName: "gradcap",     requirement: "Finish all available courses",      isUnlocked: false),
    ]

    @State private var tappedAchievement: Achievement? = nil
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    var body: some View {
        
        ScrollView(.vertical) {
            VStack{
                HStack{
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(.yellow)
                        .rotationEffect(.degrees(60))
                        .offset(y: -20)
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.red)
                        .rotationEffect(.degrees(90))
                }.frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("Achievements")
                    .foregroundColor(.red)
                    .font(.custom("Soopafresh", size: 40))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(achievements) { achievement in
                        ZStack(alignment: .topTrailing) {
                            Image(achievement.imageName)
                                .resizable()
                                .scaledToFit()
                                .grayscale(achievement.isUnlocked ? 0 : 1)
                                .opacity(achievement.isUnlocked ? 1.0 : 0.5)
                                .onTapGesture {
                                    tappedAchievement = achievement
                                }

                            if !achievement.isUnlocked {
                                Text("🔒").padding(4)
                                
          .sheet(item: $tappedAchievement) { achievement in
            VStack(spacing: 20) {
               Image(achievement.imageName)
             .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    .grayscale(achievement.isUnlocked ? 0 : 1)
                 .opacity(achievement.isUnlocked ? 1.0 : 0.5)
                Text(achievement.isUnlocked ? "✅ Unlocked!" : "🔒 Locked")
                             .font(.headline)
                             Text(achievement.requirement)
                          .multilineTextAlignment(.center)
                            .padding()
                                        }
                      // .padding()
                       .presentationDetents([.medium])
                                    }
                            }
                        }
                      //  .padding()
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    AchievementsView()
}
