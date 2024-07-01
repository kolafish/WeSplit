//
//  AddView.swift
//  WeSplit
//
//  Created by Kola on 2024/7/1.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    var expensep: Expenses
    var expenseb: Expenses

    @Environment(\.dismiss) var dismiss



    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    if (type == "Personal") {
                        expensep.items.append(item)
                    } else {
                        expenseb.items.append(item)
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
    AddView(expensep: Expenses(k:"P"),expenseb: Expenses(k:"B"))
}
