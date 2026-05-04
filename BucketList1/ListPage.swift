//
//  ListPage.swift
//  BucketList1
//
//  Created by Jendayi Anderson on 4/20/26.
//

import SwiftUI
import SwiftData

func starColor(for task: BucketItem) -> Color {
    let colors: [Color] = [.yellow, .green, .purple, .red, .pink, .orange]
    let index = abs(task.task.hashValue) % colors.count
    return colors[index]
}

struct ListPage: View {
    var selectedItems: Set<String> = []
    @State private var tasks: [BucketItem] = []
    @State private var showAddSheet = false
    @State private var selectedTab = 0
    @State private var showToast = false
    @State private var addedTaskName = ""

    var activeTasks: [BucketItem] { tasks.filter { !$0.isCompleted } }
    var completedTasks: [BucketItem] { tasks.filter { $0.isCompleted } }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            ScrollView {
                VStack {
                    Text(selectedTab == 0 ? "Adventure List" : "Completed List")
                        .font(.custom("soopafresh", size: 40))
                        .foregroundStyle(Color.redd)
                        .padding(.top, 16)
                        .padding(.bottom, 12)
                        .animation(.none, value: selectedTab)

                    Picker("", selection: $selectedTab) {
                        Image(systemName: "list.bullet").tag(0)
                        Image(systemName: "checkmark").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)

                    let displayedTasks = selectedTab == 0 ? activeTasks : completedTasks

                    if displayedTasks.isEmpty {
                        Text(selectedTab == 0 ? "No tasks yet!" : "Nothing completed yet.")
                            .foregroundStyle(Color.gray)
                            .padding(.top, 40)
                    } else {
                        ForEach(displayedTasks) { task in
                            if let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) {
                                NavigationLink {
                                    DetailView(item: $tasks[taskIndex])
                                } label: {
     HStack(alignment: .top, spacing: 14) {
Image(systemName: "star.fill")
              .font(.system(size: 28))
                      .foregroundStyle(starColor(for: task))
                        .padding(.top, 2)
                 Text(task.task)
                    .font(.system(size: 16, weight: .bold))
                           .foregroundStyle(task.isCompleted ? Color.gray : Color.primary)
                      .strikethrough(task.isCompleted, color: .redd)
                         .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 14)
                                }
                                .buttonStyle(.plain)
                                .swipeActions(edge: .trailing) {
          if selectedTab == 1 {
           Button {
                 tasks[taskIndex].isCompleted = false
                   } label: {
                  Label("Move Back", systemImage: "arrow.uturn.left")
                            }
                           .tint(.orange)
                                    }
                                }
                     Divider().padding(.leading, 56)
                            }
                        }
                    }
                }
                .padding(.bottom, 100)
            } // ← ScrollView ends here

            // Plus button — active tab only
            if selectedTab == 0 {
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

            // Toast : used for quick alerts like messages.
            if showToast {
                VStack {
                    Spacer()
                    Text("\"\(addedTaskName)\" added!")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color(.black).opacity(0.85))
                        .clipShape(Capsule())
                        .padding(.bottom, 110)

                }
            }

        } // ← ZStack ends here
        .onAppear {
            if tasks.isEmpty {
                let picked = interestTasks.filter { selectedItems.contains($0.linkedInterest) }
                tasks = defaultTasks + picked
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddTaskSheet(currentTasks: $tasks, selectedItems: selectedItems) { taskName in
                addedTaskName = taskName
                withAnimation { showToast = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation { showToast = false }
                }
            }
        }
    } // ← var body ends here
} // ← ListPage ends here

// MARK: - Task Row

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
                    Image(systemName: "star.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(starColor(for: item))
                        .padding(.top, 2)
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

// MARK: - Add Task Sheet

struct AddTaskSheet: View {
    @Binding var currentTasks: [BucketItem]
    let selectedItems: Set<String>
    var onTasksAdded: (String) -> Void
    @Environment(\.dismiss) var dismiss

    var availableTasks: [BucketItem] {
        let currentIDs = Set(currentTasks.map { $0.task })
        return interestTasks.filter { !currentIDs.contains($0.task) }
    }

    var body: some View {
        NavigationStack {
            List(availableTasks) { item in
                Button {
                    currentTasks.append(item)
                    onTasksAdded(item.task)
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
