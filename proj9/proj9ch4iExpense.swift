//
//  proj9ch4iExpense.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/3.
//

import SwiftUI

struct proj9ch4iExpense: View {
    @State private var expensesPersonal = Expenses(k : "p")
    @State private var expensesBusiness = Expenses(k : "B")
    @State private var path = [Int]()



    var body: some View {
        NavigationStack(path: $path) {
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
                        }                }
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
            .navigationBarBackButtonHidden()

            .navigationTitle("iExpense")
            .navigationBarBackButtonHidden()

            .toolbar {
                EditButton()
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    path = [32]
                }
                

            }
            .navigationDestination(for: Int.self) { selection in
                AddView2(expensep: expensesPersonal, expenseb:expensesBusiness, path : $path)
            }
            .navigationBarBackButtonHidden()

            
        }
       
    }
    func removeItemsP(at offsets: IndexSet) {
        expensesPersonal.items.remove(atOffsets: offsets)
    }
    func removeItemsB(at offsets: IndexSet) {
        expensesBusiness.items.remove(atOffsets: offsets)
    }
   
}



struct AddView2: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    var expensep: Expenses
    var expenseb: Expenses
    @Binding var path: [Int]
    @State private var title = "issue name"


    let types = ["Business", "Personal"]

    var body: some View {
            Form {
                TextField("Name", text: $title)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Save") {
                        let item = ExpenseItem(name: title, type: type, amount: amount)
                        if (type == "Personal") {
                            expensep.items.append(item)
                        } else {
                            expenseb.items.append(item)
                        }
                        path.removeAll()
                    }
                }
                ToolbarItem(placement: .cancellationAction)
                {
                    Button("Cacell") {
                        path.removeAll()
                    }
                }
            }

    }
}


#Preview {
    proj9ch4iExpense()
}
