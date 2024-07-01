//
//  iExpense.swift
//  WeSplit
//
//  Created by Kola on 2024/7/1.
//

import SwiftUI
import Observation


@Observable
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct SecondView: View {
    let name: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text("Hello, \(name)!")
        Button("Dismiss") {
            dismiss()
        }
    }
}
struct iExpenseTest: View {
    @State private var user = User()
    @State private var showingSheet = false
    @State private var numbers = [Int]()

    @AppStorage("Tap") private var currentNumber = 0


    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
        Button("Show Sheet") {
            // show the sheet
            showingSheet.toggle()

        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@twostraws")
        }
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }

    }
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    iExpenseTest()
}
