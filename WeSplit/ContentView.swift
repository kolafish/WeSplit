//
//  ContentView.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/6/26.
//

//
//  ContentView.swift
//  WeSplit
//
//  Created by Kola on 2024/6/26.
//

import SwiftUI
import SwiftData


struct ContentView: View {
 
        
    @Query var students: [Student]
    @Environment(\.modelContext) var modelContext


    
    
    var body: some View {
        NavigationStack {

            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    print("before insert")
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!

                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                    modelContext.insert(student)
                    print("finish insert")

                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Student.self, inMemory: false)

}
