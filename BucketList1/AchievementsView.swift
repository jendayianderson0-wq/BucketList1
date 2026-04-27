//
//  AchievementsView.swift
//  BucketList
//
//  Created by Charlotte Robinson on 4/12/26.
//

import SwiftUI

struct AchievementsView: View {
//    @State var badge: Badge
//    
//    @State private var badges: [Badge] = [
//        Badge(imageName: "B1", isUnlocked: true),
//        Badge(imageName: "B2", isUnlocked: false),
//        Badge(imageName: "B3", isUnlocked: false),
//        Badge(imageName: "B4", isUnlocked: false),
//        Badge(imageName: "B5", isUnlocked: false)
//    ]
    
    var body: some View {
     
        ScrollView(.vertical) {
        VStack{
            HStack{
                
                Image(systemName: "star.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.pink)
                    .rotationEffect(.degrees(90))
                
                NavigationLink {
                  HomeroomView()
               } label: {
                    Image(systemName: "folder.fill")
                }
                
                Image(systemName: "star.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.pink)
                    .rotationEffect(.degrees(90))
            }.frame(maxWidth: .infinity, alignment: .trailing)
            
            Text("Achievements")
                .foregroundColor(.red)
                .font(.custom("Soopafresh", size: 35))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack{
                
                Image("B1")
                    .resizable()
                    .scaledToFit()
                Image("B8")
                    .resizable()
                    .scaledToFit()
            }
            HStack{
                Image("B3")
                    .resizable()
                    .scaledToFit()
                Image("B4")
                    .resizable()
                    .scaledToFit()
            }
            HStack{
                Image("B5")
                    .resizable()
                    .scaledToFit()
                Image("B6")
                    .resizable()
                    .scaledToFit()
            }
            HStack{
                Image("B7")
                    .resizable()
                    .scaledToFit()
                Image("B2")
                    .resizable()
                    .scaledToFit()
            }
            HStack{
                Image("B9")
                    .resizable()
                    .scaledToFit()
                Image("B10")
                    .resizable()
                    .scaledToFit()
            }
            }
        }
    }
}

#Preview {
    AchievementsView()
}
