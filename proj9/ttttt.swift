//
//  ttttt.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/3.
//

import SwiftUI

struct ttttt: View {
    @State private var expensesPersonal = Expenses(k : "p")
    @State private var expensesBusiness = Expenses(k : "B")
    @State private var expenses = Expenses(k  : "D")
    @State private var showingAddExpense = false
    
    @State private var path2 = [Int]()
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Select Number:", value: 2)
                NavigationLink("Select string:", value:"a string")
                NavigationLink (value: "hhhha" )
                {
                    tttt8()
                }
                
                
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
        }
    }
    
}


struct tttt8 : View {
    var body : some View {
        Text("view from inside")
    }
}
struct TitleTTT: ViewModifier {
    func body(content: Content) -> some View {
        Text("view from inside")

    }
}

#Preview {
    ttttt()
}
