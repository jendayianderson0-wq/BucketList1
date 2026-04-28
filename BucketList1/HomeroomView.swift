//
//  HomeroomView.swift
//  BucketList
//
//  Created by Charlotte Robinson on 4/9/26.
//

import SwiftUI

// ── Daily Affirmations
let dailyAffirmations: [String] = [
    "Confidence comes AFTER you try, not before",
    "Awkward moments make the best stories later",
    "Discipline is choosing what you want MOST over what you want now",
     "Don’t let fear make you miss out",
    "Be brave enough to be bad at something new",
    "Planning a group hangout works best when you keep it simple",
    "Pick 1 activity, 1 place, and 1 time, don’t overcomplicate it",
    "Reconnecting with someone can be as simple as a short message.“Hey, I was just thinking about you, how have you been?",
    " Asking a question in class helps you understand faster and shows your teacher you care. If you’re nervous, write your question down first",
    "Organizing your backpack and files saves time and reduces stress. Throw away old papers and group things by subject",
    "Organizing your backpack and files saves time and reduces stress. Throw away old papers and group things by subject",

]

struct HomeroomView: View {
    @AppStorage("weeklyTaskIDs") private var weeklyTaskIDsRaw: String = ""
    @AppStorage("weeklyTaskDate") private var weeklyTaskDateRaw: Double = 0
    
    // Picks a different affirmation each day based on the day of the year
    private var todaysAffirmation: String {
        let day = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        return dailyAffirmations[day % dailyAffirmations.count]
    }
    
    private var weeklyTasks: [BucketItem] {
        let saved = Date(timeIntervalSince1970: weeklyTaskDateRaw)
        let oneWeek: TimeInterval = 7 * 24 * 60 * 60
        let needsRefresh = weeklyTaskIDsRaw.isEmpty || Date().timeIntervalSince(saved) > oneWeek
        
        if needsRefresh {
            let uncompleted = defaultTasks.filter { !$0.isCompleted }
            let picked = Array(uncompleted.shuffled().prefix(3))
            weeklyTaskIDsRaw = picked.map { $0.task }.joined(separator: "||")
            weeklyTaskDateRaw = Date().timeIntervalSince1970
            return picked
        }
        
        let ids = Set(weeklyTaskIDsRaw.components(separatedBy: "||"))
        return defaultTasks.filter { ids.contains($0.task) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // ── Trophy / Stars header ──
                        VStack {
                            Image(systemName: "star.fill")
                                .font(.system(size: 28))
                                .foregroundStyle(.pink)
                                .rotationEffect(.degrees(90))
                            HStack {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 34))
                                    .foregroundStyle(.yellow)
                                    .rotationEffect(.degrees(90))
                                NavigationLink {
                                    AchievementsView()
                                } label: {
                                    Text("🏆")
                                        .font(.system(size: 55))
                                }
                                Image(systemName: "star.fill")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.blue)
                                    .rotationEffect(.degrees(90))
                            }
                            
                        }
                    
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        // ── Title ──
                        Text("Homeroom")
                            .foregroundColor(.redd)
                            .font(.custom("Soopafresh", size: 50))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // ── Adventure List ──
                        VStack(spacing: 12) {
                            HStack {
                                Text("Adventure List")
                                    .foregroundStyle(.red)
                                    .fontWeight(.bold)
                                    .font(.system(size: 17))
                                Spacer()
                                NavigationLink {
                                    ListPage()
                                } label: {
                                    Text("view all")
                                        .font(.system(size: 14))
                                        .underline()
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.horizontal)
                            
  ScrollView(.horizontal, showsIndicators: false) {
     HStack(spacing: 14) {
                let colors: [Color] = [.purple, .orange, .blue]
       ForEach(Array(weeklyTasks.enumerated()), id: \.offset) { index, item in
         NavigationLink {
               ListPage()
         } label: {
                    Text(item.task)
               .font(.system(size: 15, weight: .medium))
                  .multilineTextAlignment(.center)
                  .foregroundStyle(.white)
                .frame(width: 150, height: 150)
                //.padding(12)
                 .background(
                 RoundedRectangle(cornerRadius: 20)
                           .fill(colors[index % colors.count])
                      )
                 .shadow(color: colors[index % colors.count].opacity(0.4),
                             radius: 8, x: 0, y: 4)
                                        }
                                    }
                                }
                               //.padding(.horizontal, 16)
                             //  .padding(.vertical, 4)
                            }
                            
                    .padding(.horizontal, 8)
                        }
                        
                        // ── Daily Affirmation ──
                        VStack(spacing: 12) {
                            Text("Daily Affirmation")
                                .foregroundStyle(.red)
                                .fontWeight(.bold)
                                .font(.system(size: 17))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(spacing: 8) {
                                Text(todaysAffirmation)
                                    .font(.system(size: 16, weight: .medium))
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(Color(.label))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 50)                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(.systemYellow).opacity(0.85))
                                   // .padding(.horizontal, 8)
                            )
                            .shadow(color: Color.yellow.opacity(0.4), radius: 8, x: 0, y: 4)
                        }
                        
                        .padding(.horizontal,10)
                        
                        // ── Yearbook Catalog ──
                        VStack(spacing: 12) {
                            HStack {
                                Text("Yearbook Catalog")
                                    .foregroundStyle(.red)
                                    .fontWeight(.bold)
                                    .font(.system(size: 17))
                                Spacer()
                                NavigationLink {
                                    YearbookView()
                                } label: {
                                    Text("view all")
                                        .font(.system(size: 14))
                                        .underline()
                                        .foregroundStyle(.secondary)
                                }
                            }
                            
                            .padding(.vertical,10)
                            .padding(.horizontal,10)
                            
                          //  .padding()
            ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
        ForEach(["one", "two", "three"], id: \.self) { name in
        let uiImage = UIImage(named: name)
    if uiImage != nil {
        // Real image if it exists
    Image(name)
       .resizable()
      .scaledToFill()
                            .frame(width: 200, height: 150)
                             .clipped()
                               .cornerRadius(16)
                                  .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                              } else {
                       // Filler placeholder box
                  RoundedRectangle(cornerRadius: 16)
                     .fill(Color(.systemGray5))
                        .frame(width: 200, height: 150)
                         .overlay(
                        VStack(spacing: 8) {
                                Image(systemName: "photo")
                            .font(.system(size: 28))
                             .foregroundStyle(Color(.systemGray3))
                                   Text("Coming Soon")
                                .font(.system(size: 12))
                    .foregroundStyle(Color(.systemGray3))
                       }
                                                )
                         .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
                                        }
                                    }
                                }
                            }
                        }
                        
                        .padding(.horizontal,5)
                        .padding(.vertical,5)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeroomView()
}
