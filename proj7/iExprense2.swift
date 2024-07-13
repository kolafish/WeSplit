//
//  iExprense2.swift
//  WeSplit
//
//  Created by Kola on 2024/7/1.
//

import SwiftUI
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
@Observable
class Expenses {
    var key : String
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
    init(k :String) {
        key = k
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}


struct iExprense2: View {
    @State private var expensesPersonal = Expenses(k : "p")
    @State private var expensesBusiness = Expenses(k : "B")
    @State private var expenses = Expenses(k  : "D")
    @State private var showingAddExpense = false


    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expensesPersonal.items, id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(item.amount >= 1000 ? .red : item.amount < 100 ? .secondary : .primary)
                        }
                        .accessibilityElement()
                        .accessibilityLabel(item.name + String(item.amount))
                        .accessibilityHint(item.type)
                    }
                    .onDelete(perform: removeItemsP)
                }
                Section("Business") {
                    ForEach(expensesBusiness.items, id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(item.amount >= 1000 ? .red : item.amount < 100 ? .secondary : .primary)
                        }                }
                    .onDelete(perform: removeItemsB)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expensep: expensesPersonal, expenseb:expensesBusiness)
                // show an AddView here
            }
            .toolbar {
                EditButton()
            }
            
        }
    }
    func removeItemsP(at offsets: IndexSet) {
        expensesPersonal.items.remove(atOffsets: offsets)
    }
    func removeItemsB(at offsets: IndexSet) {
        expensesBusiness.items.remove(atOffsets: offsets)
    }
}



#Preview {
    iExprense2()
}
