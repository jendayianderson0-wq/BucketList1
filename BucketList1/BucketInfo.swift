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
    var  image: Image?  = nil
}

 
 
let defaultTasks: [BucketItem] = [
    //  Every user gets these automatically
    BucketItem(task: "Write a letter to your future self", description: "Write a letter to your future self at the end of the school year. Write in future tense what you learned, how you grew, and what you hope for next. This matters because it helps you reflect, see your progress, and create a moment you’ll appreciate later.", linkedInterest: ""),
    BucketItem(task: " Try something you’re not naturally good at for a full week", description: "Try something you’re not naturally good at for a full week. Show up and practice daily. This matters because it builds confidence, resilience, and reminds you that growth comes from trying, not being perfect.", linkedInterest: ""),
    BucketItem(task: " Spend 1 hour alone doing something you enjoy (no phone)", description: "Spend 1 hour alone doing something you enjoy. No phone, just you and the moment. This matters because it helps you recharge, get to know yourself, and enjoy your own company without distractions.", linkedInterest:""),
    BucketItem(task: " Create a “reset routine” for when you feel overwhelmed", description: "Create a simple “reset routine” (like music, breathing, or a short walk) to use when you feel overwhelmed. This matters because it helps you calm down, regain control, and handle stress in a healthy way." , linkedInterest: ""),
    BucketItem(task: "Make a playlist that represents your life right now", description: "Make a playlist that represents your life right now; your mood, your growth, your vibe. This matters because it helps you express yourself, reflect on where you are, and capture this moment in time." , linkedInterest: ""),
    BucketItem(task:"Start journaling for 5 days straight", description: "Make a playlist that represents your life right now; your mood, your growth, your vibe. This matters because it helps you express yourself, reflect on where you are, and capture this moment in time." , linkedInterest: ""),
    BucketItem(task: "Create a personal motto or phrase you live by", description: "Make a playlist that represents your life right now; your mood, your growth, your vibe. This matters because it helps you express yourself, reflect on where you are, and capture this moment in time." , linkedInterest: ""),
    BucketItem(task: " Research 3 careers you’ve never considered", description: "Research 3 careers you’ve never considered. Learn what they involve and how people get there. This matters because it expands your options and helps you discover paths you didn’t know existed." , linkedInterest: ""),
    BucketItem(task: "Interview someone about their job", description: "Interview someone about their job. Ask about their daily tasks, path, and lessons learned. This matters because it gives you real-world insight and helps you make more informed decisions about your future", linkedInterest: ""),
    BucketItem(task:  "Create your first resume", description: "Interview someone about their job. Ask about their daily tasks, path, and lessons learned. This matters because it gives you real-world insight and helps you make more informed decisions about your future", linkedInterest: ""),
    BucketItem(task:"Look up the salary for a career you like and map out what your life could look like.", description: "Look up the salary for a career you like and map out your future lifestyle (apartment, car, wardrobe etc). This matters because it connects your goals to real-life decisions and planning", linkedInterest: ""),
    BucketItem(task:"Take a career personality quiz", description: "Ask someone to mentor you (even informally). Learn from their experience and advice. This matters because guidance can help you avoid mistakes and grow faster.", linkedInterest: ""),
    BucketItem(task:"Sit with someone new at lunch", description: "Sit with someone new at lunch. Start a conversation and get to know them. This matters because it builds confidence and expands your circle." , linkedInterest: ""),
    BucketItem(task: "Plan a group hangout (movie, game night, etc.)", description: "Plan a group hangout. Organize a fun activity with friends. This matters because it creates memories and strengthens friendships.", linkedInterest: ""),
    BucketItem(task:" Go to a school event (game, play, etc.)", description: "Support a friend at their event. Be there and show up for them. This matters because strong friendships are built through support.", linkedInterest: ""),
    BucketItem(task:"  Reconnect with someone you lost touch with", description: "Reconnect with someone you lost touch with. Send a message or start a conversation. This matters because relationships are worth maintaining.", linkedInterest: ""),
    BucketItem(task:"Thank someone who helped you, even if it was a long time ago", description: "Ask someone to mentor you (even informally). Learn from their experience and advice. This matters because guidance can help you avoid mistakes and grow faster.", linkedInterest: ""),
    BucketItem(task:" Improve a grade in one class", description: "Improve a grade in one class. Focus and put in extra effort. This matters because it builds discipline and confidence in your abilities.", linkedInterest: ""),
    BucketItem(task:" Ask a question in class", description: "Ask a question in class. Speak up when you don’t understand. This matters because asking questions helps you learn and stay engaged.", linkedInterest: ""),
    BucketItem(task:"Study for a test at least 3 days in advance", description: "Study for a test at least 3 days in advance. Don’t wait until the last minute. This matters because it reduces stress and improves your performance.", linkedInterest: ""),
    BucketItem(task:"Rewrite your notes in a way that helps you understand better", description: "Rewrite your notes in a way that helps you understand better. This matters because learning your way makes information stick", linkedInterest: ""),
    BucketItem(task:"Organize your backpack, notes, and digital files", description: "Organize your backpack, notes, and digital files. Clear the clutter. This matters because staying organized helps you stay focused and on track.", linkedInterest: ""),
    BucketItem(task:" Avoid procrastination for one full week", description: "Organize your backpack, notes, and digital files. Clear the clutter. This matters because staying organized helps you stay focused and on track.", linkedInterest: ""),
    
    


]
 
let interestTasks: [BucketItem] = [
    //  Career Exploration
    BucketItem(task: "Volunteer in a role that relates to a career interest",description: "This matters because it gives you real experience and helps you see if you enjoy that path.", linkedInterest: "Day in the Life"),
    BucketItem(task: " Learn how to write a professional email",description: "This matters because it helps you communicate clearly for school, jobs, and opportunities.", linkedInterest: "Communication"),
    BucketItem(task: " Make a list of your strengths ",description: "This matters because it helps you recognize what you’re good at and use it to make confident decisions about school, opportunities, and your future.", linkedInterest: "Skills"),
    BucketItem(task: "Ask a teacher for advice about your future",description: "This matters because it helps you recognize what you’re good at and use it to make confident decisions about school, opportunities, and your future.", linkedInterest: "Advice"),
    BucketItem(task: "Research scholarships or opportunities",description: "This matters because they can offer guidance and insights based on your strengths.", linkedInterest: "Money"),
    BucketItem(task: "Set a future goal and map out steps",description: "This matters because it turns your ideas into a clear plan you can actually follow.", linkedInterest: " Goal Setting"),
    BucketItem(task: "Come up with a business idea, name it, and design a quick logo or concept.",description: "This matters because it builds creativity and introduces you to the entrepreneurship and producing your own income.", linkedInterest: "Entrepreneurship"),
 
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
    BucketItem(task: "Create a tradition with your friend group",description: "This matters because traditions create lasting memories and stronger bonds.", linkedInterest: "Memories"),
    BucketItem(task: "Spend time with someone from a different background ", description: "This matters because it broadens your perspective and helps you understand others better.", linkedInterest: "Diversity"),
 
    //  Academic Progression
    BucketItem(task: "Explain something you learned in a funny or creative way. ",description: "This matters because it helps you understand it better and makes learning more enjoyable.", linkedInterest: "Creativty"),
    BucketItem(task: "Teach a concept to a friend who’s struggling",description: "This matters because teaching helps you fully understand the material.", linkedInterest: "Helping Others"),
    BucketItem(task: "Form a study group", description: "This matters because collaboration can make learning easier and more effective.", linkedInterest: "Study Budy"),
    BucketItem(task: "Improve your conversational skills(active listening and response)",           description: "This matters because strong communication helps you build better relationships.", linkedInterest: "Life Habits"),
    BucketItem(task: "Meet with a teacher for help ", description: "This matters because it helps you improve faster and shows initiative. ", linkedInterest: "Asking Questions"),
]
