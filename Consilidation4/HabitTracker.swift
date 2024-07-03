//
//  HabitTracker.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/3.
//

import SwiftUI

struct HabitItem: Identifiable, Codable, Hashable,Equatable {
    var id = UUID()
    let name: String
    let type: String
    var amount: Double
    var times : Int
    let description : String
}

struct HabitDetailView: View {
    @State var astronaut: HabitItem
    var expenseWork: Habits
    var expensePlay: Habits
    @State var amount = 0.0

    var body: some View {
        VStack(alignment: .leading) {
            Text(astronaut.description)
            mydivider1()
            Text("打卡次数 \(astronaut.times)")
            mydivider1()
            Text("打卡总时长 \(astronaut.amount)")
            mydivider1()

            Section
            {           
                HStack {
                    Text("打卡时长")
                    TextField("打卡时长", value: $amount, format: .number )
                        .keyboardType(.decimalPad)
                        .background(.gray)
                }

                Button("打卡"){
                    if (astronaut.type == "学习工作") {
                        let pos = expenseWork.items.firstIndex(of : astronaut)
                        let item = HabitItem(name: astronaut.name, type: astronaut.type, amount: astronaut.amount + amount,times : astronaut.times + 1, description: astronaut.description)
                        expenseWork.items[pos!] = item
                        astronaut = item
                    }
                    else {
                        let pos = expensePlay.items.firstIndex(of : astronaut)
                        let item = HabitItem(name: astronaut.name, type: astronaut.type, amount: astronaut.amount + amount,times : astronaut.times + 1, description: astronaut.description)
                        expensePlay.items[pos!] = item
                        astronaut = item
                    }
                }
                .disabled(amount < 0.5)
                
            }
        }
        .padding()
//        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    struct mydivider1: View {
        var body: some View {
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.lightBackground)
                .padding(.vertical)
        }
    }
}

@Observable
class Habits {
    var key : String
    var items = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
    init(k :String) {
        key = k
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct HabitTracker: View {
    @State private var expensesWork = Habits(k : "habitwork")
    @State private var expensesPlay = Habits(k : "habitplay")
    @State private var showingAddExpense = false


    var body: some View {
        NavigationStack {
            List {
                Section("学习工作") {
                    ForEach(expensesWork.items, id: \.id) { item in
                        NavigationLink(item.name, value:item)
                    }
                    .onDelete(perform: removeItemsWork)
                }
                Section("休闲娱乐") {
                    ForEach(expensesPlay.items, id: \.id) { item in
                        NavigationLink(item.name, value:item)
                    }
                    .onDelete(perform: removeItemsPlay)
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView4Habit(expenseWork: expensesWork, expensePlay:expensesPlay)
            }
            .toolbar {
                EditButton()
            }
            .navigationDestination(for: HabitItem.self) { selection in
                HabitDetailView(astronaut :selection, expenseWork: expensesWork, expensePlay: expensesPlay)
            }
            
        }
    }
    func removeItemsWork(at offsets: IndexSet) {
        expensesWork.items.remove(atOffsets: offsets)
    }
    func removeItemsPlay(at offsets: IndexSet) {
        expensesPlay.items.remove(atOffsets: offsets)
    }
}

struct AddView4Habit: View {
    @State private var description = ""
    @State private var type = "学习工作"
    @State private var amount = 0.0
    var expenseWork: Habits
    var expensePlay: Habits
    @State private var title = "Add new habit"

    @Environment(\.dismiss) var dismiss



    let types = ["学习工作", "休闲娱乐"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $title)
                TextField("description", text: $description)


                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .number )
                    .keyboardType(.decimalPad)

                
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = HabitItem(name: title, type: type, amount: amount, times : 1, description:description)
                    if (type == "学习工作") {
                        expenseWork.items.append(item)
                    } else {
                        expensePlay.items.append(item)
                    }
                }
            }
        }
        Button("Dismiss") {
            dismiss()
        }
    }
}


#Preview {
    HabitTracker()
}
