//
//  ListPage.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/14/26.
//

import SwiftUI
import SwiftData


struct ListPage: View {
    var selectedItems: Set<String> = []
 
    // State lives here so checkboxes and added tasks persist while on this screen
    @State private var tasks: [BucketItem] = []
    @State private var showAddSheet = false
 
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack() {
                    Text("Adventure List")
                        .font(.custom("soopafresh", size: 40))
                        .foregroundStyle(Color.redd)
                        .padding(.top, 16)
                        .padding(.bottom, 12)
 
                    // Task rows
                    ForEach($tasks.sorted(by: { !$0.isCompleted.wrappedValue && $1.isCompleted.wrappedValue })) { $item in
                        NavigationLink {
                            DetailView(item: $item)
                        } label: {
                            TaskRow(item: $item)
                        }
                        .buttonStyle(.plain)
 
                        Divider().padding(.leading, 56)
                    }
                }
                .padding(.bottom, 100)
            }
 
            Button { showAddSheet = true } label: {
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color.red)
                    .clipShape(Circle())
            }
            .padding(.trailing, 24)
            .padding(.bottom, 32)
        }
       // .navigationBarTitleDisplayMode(.inline)
        .onAppear {
        
            if tasks.isEmpty {
                let picked = interestTasks.filter { selectedItems.contains($0.linkedInterest) }
                tasks = defaultTasks + picked
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddTaskSheet(currentTasks: $tasks, selectedItems: selectedItems)
        }
    }
}
 
// ── MARK: Task Row ────────────────────────────────────────────
 
struct TaskRow: View {
    @Binding var item: BucketItem
 
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Button {
                item.isCompleted.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.primary, lineWidth: 1.5)
                        .frame(width: 24, height: 24)
                    if item.isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding(.top, 2)
 
            Text(item.task)
                .font(.system(size: 16))
                .foregroundStyle(item.isCompleted ? Color.gray : Color.primary)
                .strikethrough(item.isCompleted, color: .redd)
                .multilineTextAlignment(.leading)
 
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}

struct AddTaskSheet: View {
    @Binding var currentTasks: [BucketItem]
    let selectedItems: Set<String>
    @Environment(\.dismiss) var dismiss
 
    // Every task not already on the list
    var availableTasks: [BucketItem] {
        let currentIDs = Set(currentTasks.map { $0.task })
        return interestTasks.filter { !currentIDs.contains($0.task) }
    }
 
    var body: some View {
        NavigationStack {
            List(availableTasks) { item in
                Button {
                    currentTasks.append(item)
                    dismiss()
                } label: {
                    Text(item.task)
                        .foregroundStyle(Color.primary)
                }
            }
            .navigationTitle("Add a Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
 

#Preview {
    ListPage()
}
