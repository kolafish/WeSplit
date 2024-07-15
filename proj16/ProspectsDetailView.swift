//
//  ProspectsDetailView.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/15.
//

import SwiftUI
import SwiftData

struct ProspectsDetailView: View {
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    @State private var selectedProspects = Set<Prospect>()

    
    var body: some View {
        List(prospects, selection: $selectedProspects) { prospect in
            NavigationLink {
                EditProspect(p : prospect)
            } label: {
                VStack(alignment: .leading) {
                    HStack {
                        Text(prospect.name)
                            .font(.headline)
                        if prospect.isContacted {
                            Image(systemName:  "person.crop.circle.badge.xmark")
                        } else {
                            Image(systemName:  "person.crop.circle.fill.badge.checkmark")
                        }
                    }
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                    Text(prospect.jionDate?.ISO8601Format() ?? "None")
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                    }
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
            }
            .tag(prospect)
        }
        .toolbar {
            if selectedProspects.isEmpty == false {
                ToolbarItem(placement: .bottomBar) {
                    Button("Delete Selected", action: delete)
                }
            }
        }
    }

    init(filter: ProspectsView.FilterType, sortOrder: [SortDescriptor<Prospect>]) {
//        self.filter = /*filter*/

        if filter != .none {
            let showContactedOnly = filter == .contacted

            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: sortOrder)
        } else  {
            _prospects = Query(sort: sortOrder)
        }
    }
    
//    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<UserP12>]) {
//        _users = Query(filter: #Predicate<UserP12> { user in
//            user.joinDate >= minimumJoinDate
//        }, sort: sortOrder)
//    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
}

#Preview {
    ProspectsDetailView(filter : ProspectsView.FilterType.none, sortOrder: [SortDescriptor(\Prospect.jionDate)])
        .modelContainer(for: Prospect.self, inMemory: false)
}
