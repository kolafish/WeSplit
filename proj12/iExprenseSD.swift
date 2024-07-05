//
//  iExprenseSD.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/5.
//

import SwiftUI
import SwiftData


enum ExType {
    case Personal
    case Bussiness
}

@Model
class ExpensesSD {

    var name: String
    var amount: Double
    var extype : String
    
    init(name: String, amount: Double, extype: String) {
        self.name = name
        self.amount = amount
        self.extype = extype
    }
}



struct iExprenseSD: View {
    @State private var showingAddExpense = false
    @Environment(\.modelContext) var modelContext

//    @Query(filter: #Predicate<ExpensesSD> { user in
//        user.extype == .Personal }, sort: \ExpensesSD.amount) var exP: [ExpensesSD]
//    @Query(filter: #Predicate<ExpensesSD> { user in
//        user.extype == .Bussiness }, sort: \ExpensesSD.amount) var exB: [ExpensesSD]
    
    @State private var sortOrder = [
        SortDescriptor(\ExpensesSD.name),
        SortDescriptor(\ExpensesSD.amount),
    ]
    let filtertype = ["All","Business", "Personal"]
    @State private var selecttype = "All"


    var body: some View {
        NavigationStack {
            ExpView(sortOrder: sortOrder, selecttype:selecttype)
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem() {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                }
                ToolbarItem() {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\ExpensesSD.name),
                                    SortDescriptor(\ExpensesSD.amount)
                                ])
                            
                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\ExpensesSD.amount),
                                    SortDescriptor(\ExpensesSD.name)
                                ])
                        }
                    }
                }
                ToolbarItem() {
                    Menu("OnlyFilter") {
                        Picker("Filter", selection: $selecttype) {
                            ForEach(filtertype, id: \.self) {
                                Text($0)
                            }
                        }
                    }

                }
            }
            .sheet(isPresented: $showingAddExpense) {
                SDAddView()
            }

            
        }
    }

}


struct ExpView: View {
    @Query var exs: [ExpensesSD]
    @Environment(\.modelContext) var modelContext


    var body: some View {
        List {
            ForEach(exs, id: \.id) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.extype )
                    }
                    Spacer()
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(item.amount >= 1000 ? .red : item.amount < 100 ? .secondary : .primary)
                }
            }
            .onDelete(perform: removeItemsP)

        }
    }
    init(sortOrder: [SortDescriptor<ExpensesSD>], selecttype : String) {
            _exs = selecttype == "All" ? Query( sort: sortOrder) : Query(filter: #Predicate<ExpensesSD> { user in
                user.extype == selecttype
            }, sort: sortOrder)
    }
    
    func removeItemsP(at offsets: IndexSet) {
        for offset in offsets {
            let book = exs[offset]
            modelContext.delete(book)
        }
    }
}


struct SDAddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext




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
                    let item = ExpensesSD(name: name, amount: amount, extype : type )
                    modelContext.insert(item)
                    dismiss()
                }
                .disabled(name.isEmpty || amount == 0.0)
            }
        }

    }
}




#Preview {
    iExprenseSD()
        .modelContainer(for: ExpensesSD.self, inMemory: false , isAutosaveEnabled: true)
}
