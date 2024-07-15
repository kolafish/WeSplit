//
//  ProspectsView.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/15.
//

import SwiftUI
import SwiftData
import CodeScanner
import UserNotifications

struct EditProspect : View {
    @Bindable var p : Prospect
    var body : some View {
        Form {
            TextField("Name", text: $p.name)
                .font(.title)

            TextField("Email address", text: $p.emailAddress)
                .font(.title)
        }

    }
}





struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }
    @Environment(\.modelContext) var modelContext
    @State private var isShowingScanner = false

    @State private var sortOrder = [
        SortDescriptor(\Prospect.jionDate)
    ]
    
 
    
    var body: some View {
        NavigationStack {
            ProspectsDetailView(filter: filter, sortOrder: sortOrder)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\Prospect.name),
                                    SortDescriptor(\Prospect.jionDate),
                                ])
                            
                            Text("Sort by Join Date")
                                .tag([
                                    SortDescriptor(\Prospect.jionDate),
                                    SortDescriptor(\Prospect.name),
                                ])
                            
                        }
                    }
                }
  
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }

        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
       isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)

            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    

    
    
    
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self, inMemory: false)

}
