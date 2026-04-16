//
//  BucketInfo.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/16/26.
//

import SwiftUI
import PhotosUI
 
 
struct BucketItem: Identifiable {
    let id = UUID()
    let task: String
    let description: String
    let linkedInterest: String
    var isCompleted: Bool = false
}
 
 
let defaultTasks: [BucketItem] = [
    //  Every user gets these automatically
    BucketItem(task: "Write a letter to your future self", description: "Write a letter to your future self at the end of the school year. Write in future tense what you learned, how you grew, and what you hope for next. This matters because it helps you reflect, see your progress, and create a moment you’ll appreciate later.", linkedInterest: ""),
    BucketItem(task: " Try something you’re not naturally good at for a full week", description: "Try something you’re not naturally good at for a full week. Show up and practice daily. This matters because it builds confidence, resilience, and reminds you that growth comes from trying, not being perfect.", linkedInterest: ""),
]
 
let interestTasks: [BucketItem] = [
    //  Career Exploration
    BucketItem(task: "Task for Day in the Life",       description: "✏️ description here", linkedInterest: "Day in the Life"),
    BucketItem(task: "Task for Communication",         description: "✏️ description here", linkedInterest: "Communication"),
    BucketItem(task: "Task for Skills",                description: "✏️ description here", linkedInterest: "Skills"),
    BucketItem(task: "Task for Advice",                description: "✏️ description here", linkedInterest: "Advice"),
    BucketItem(task: "Task for Money",                 description: "✏️ description here", linkedInterest: "Money"),
    BucketItem(task: "Task for Goal Setting",          description: "✏️ description here", linkedInterest: " Goal Setting"),
    BucketItem(task: "Task for Entrepreneurship",      description: "✏️ description here", linkedInterest: "Entrepreneurship"),
 
    //  Personal Development
    BucketItem(task: " Learn how to cook one full meal with your parent/guardian ",description: "This matters because it teaches independence and creates a meaningful memory.", linkedInterest: "Cooking"),
    BucketItem(task: " Write down 10 things you like about yourself",   description: "This matters because it builds confidence and helps you focus on your strengths.", linkedInterest: " Confidence Building"),
    BucketItem(task: "Write a list of your top 5 values (what matters most to you) ",description: "This matters because it helps guide your decisions and shape who you are.", linkedInterest: "Personal Values"),
    BucketItem(task: "Try a new workout or movement activity", description: "This matters because it keeps you active and helps you discover what you enjoy.", linkedInterest: "Fitness"),
    BucketItem(task: "Spend a day intentionally choosing positive thoughts",description: "This matters because your mindset shapes how you feel and respond to life.", linkedInterest: "Happy Thoughts"),
    BucketItem(task: "Write about a challenge you overcame and what it taught you",description: "This matters because it reminds you of your strength and growth.", linkedInterest: "Do Hard Things"),
 
    //  Social Connection
    BucketItem(task: " Compliment 5 people in one day",description: "This matters because it spreads positivity and strengthens your connections with others.", linkedInterest: "Compliments"),
    BucketItem(task: "Ask Better Questions Day Instead of “how are you,” ask something deeper like “what made you smile today?", description: "This matters because deeper questions lead to more real and memorable conversations.", linkedInterest: " Conversation Starters"),
    BucketItem(task: "Thank a teacher who impacted you", description: "This matters because showing appreciation builds relationships and leaves a lasting impression.", linkedInterest: "Gratitude"),
    BucketItem(task: "Participate in spirit week", description: "This matters because it helps you feel included and makes school more fun.", linkedInterest: "Fun"),
    BucketItem(task: "Task for Memories",              description: "✏️ description here", linkedInterest: "Memories"),
    BucketItem(task: "Task for Diversity",             description: "✏️ description here", linkedInterest: "Diversity"),
 
    //  Academic Progression
    BucketItem(task: "Task for Creativity",            description: "✏️ description here", linkedInterest: "Creativty"),
    BucketItem(task: "Task for Helping Others",        description: "✏️ description here", linkedInterest: "Helping Others"),
    BucketItem(task: "Task for Study Buddy",           description: "✏️ description here", linkedInterest: "Study Budy"),
    BucketItem(task: "Task for Life Habits",           description: "✏️ description here", linkedInterest: "Life Habits"),
    BucketItem(task: "Task for Asking Questions",      description: "✏️ description here", linkedInterest: "Asking Questions"),
]
