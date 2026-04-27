//
//  InterestPageView.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/20/26.
//

import SwiftUI



struct InterestCategory: Identifiable {
    let id = UUID()
    let emoji: String
    let name: String
    let items: [String]
    let color: Color
}
let categories: [InterestCategory] = [
    InterestCategory(emoji: "💰", name: "Career Exploration", items: ["Day in the Life", "Communication", "Skills", "Advice", "Money"," Goal Setting", "Entrepreneurship"], color: .peach),
    InterestCategory(emoji: "💪🏾", name: "Personal Development", items: ["Cooking", " Confidence Building", "Personal Values", "Fitness", "Happy Thoughts", "Do Hard Things"], color: .purpley),
    InterestCategory(emoji: "💬", name: "Social Connection", items: ["Compliments", " Conversation Starters","Gratitude", "Fun", "Memories", "Diversity"], color: .pinky),
    InterestCategory(emoji:"📚", name: "Academic Progession", items: ["Creativty","Helping Others","Study Buddy","Life Habits", "Asking Questions"], color:.limegreen)
]

struct InterestBubble: View {
    let title: String
    let color: Color
    @Binding var selectedItems: Set<String>
    
    var isSelected: Bool {
        selectedItems.contains(title)
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 14))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? color.opacity(0.2) : Color(.systemGray6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? color : Color.clear, lineWidth: 1.5)
            )
            .foregroundStyle(Color.primary)
            .onTapGesture {
                if isSelected {
                    selectedItems.remove(title)
                } else {
                    // Use Swift Data to save selectedItems
                        // that saved selectedItems will be called later in our ListPage
                    selectedItems.insert(title)
                }
            }
    }
}

struct ChipRow: View {
    let items: [String]
    let color: Color
    @Binding var selectedItems: Set<String>
    
    // Split items into chunks of 5
    var rows: [[String]] {
        stride(from: 0, to: items.count, by: 5).map {
            Array(items[$0..<min($0 + 5, items.count)])
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(rows, id: \.self) { row in
                    HStack(spacing: 8) {
                        ForEach(row, id: \.self) { item in
                            InterestBubble(title: item, color: color, selectedItems: $selectedItems)
                        }
                    }
                }
            }
            .padding(.horizontal, 2)
        }
    }
}

struct CategorySection: View {
    let category: InterestCategory
    @Binding var selectedItems: Set<String>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Text(category.emoji)
                    .font(.system(size: 18))
                Text(category.name)
                    .font(.system(size: 16, weight: .bold))
            }
            
            ChipRow(items: category.items, color: category.color, selectedItems: $selectedItems)
        }
    }
}


struct InterestPageView: View {
    var onComplete: (() -> Void)? = nil
    // This needs Set needs to be saved when Continue is selected
    @State private var selectedItems: Set<String> = []
    let requiredCount = 10
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                VStack {
                    Text("Interest")
                        .font(.custom("soopafresh", size: 40))
                        .foregroundStyle(Color.redd)
                    
                    Text("Select things you’d like to see in your bucket list.")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.gray)
                        .bold()
                    
                    // Spacer()
                    
                    
                    // selected items amount
                    Text("\(selectedItems.count)/10")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color.gray)
                        .padding(.bottom,40)
                        .padding()
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(categories) { category in
                        CategorySection(category: category, selectedItems: $selectedItems)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom)
                
                NavigationLink {
                   HomeroomView()
                    // We need to saved our selectedItems
                    // Navigate to our HomeRoom
                } label: {
                    Text("Continue")
                        .padding()
                        .frame(width: 200)
                        .background(
                            selectedItems.count >= requiredCount
                            ? LinearGradient(colors: [Color.redd, Color.red], startPoint: .leading, endPoint: .trailing)
                            : LinearGradient(colors: [Color.gray, Color.gray], startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                .disabled(selectedItems.count < requiredCount)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}



#Preview {
    InterestPageView()
}

