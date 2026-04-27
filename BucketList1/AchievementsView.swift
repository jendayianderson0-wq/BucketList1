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
    
    let stickers: [String] = [ "trophy", "rocket", "popcorn", "diamond", "pencil", "target", "flag", "notebook", "bulb", "mic", "spaceship", "meteor", "firecracker", "bomb", "fire", "gradcap" ]
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
                    ForEach(stickers, id: \.self) { sticker in
                        Image(sticker)
                            .resizable()
                            .scaledToFit()
                        
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    AchievementsView()
}
