//
//  proj10networktest1.swift
//  WeSplit
//
//  Created by Kola on 2024/7/3.
//

import SwiftUI
struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct proj10networktest1: View {
    @State private var results = [Result]()
    @State private var username = "Jin"
    @State private var email = "123@456.com"
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }

       var body: some View {
//           AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)

           
           AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
               image
                   .resizable()
                   .scaledToFit()
           } placeholder: {
               Color.gray
           }
           .frame(width: 100, height: 100)
           
           AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
               if let image = phase.image {
                   image
                       .resizable()
                       .scaledToFit()
               } else if phase.error != nil {
                   Text("There was an error loading the image.")
               } else {
                   ProgressView()
               }
           }
           .frame(width: 100, height: 100)
           
           Form {
                       Section {
                           TextField("Username", text: $username)
                           TextField("Email", text: $email)
                       }

                       Section {
                           Button("Create account") {
                               print("Creating account…")
                           }
                       }
                       .disabled(disableForm)

               }


           List(results, id: \.trackId) { item in
               VStack(alignment: .leading) {
                   Text(item.trackName)
                       .font(.headline)
                   Text(item.collectionName)
               }
           }
           .task {
               await loadData()
           }
       }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    proj10networktest1()
}
