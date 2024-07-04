//
//  Bookworm.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/4.
//

import SwiftUI
import SwiftData


struct Bookworm: View {
    @Query var books: [Book]
    @Environment(\.modelContext) var modelContext
    @State private var showingAddScreen = false


    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookworm")
               .toolbar {
                   ToolbarItem(placement: .topBarTrailing) {
                       Button("Add Book", systemImage: "plus") {
                           showingAddScreen.toggle()
                       }
                   }
               }
               .sheet(isPresented: $showingAddScreen) {
                   AddBookView()
               }
               .navigationDestination(for: Book.self) { book in
                   DetailView(book: book)
               }
       }
    }
}

#Preview {
    Bookworm()
        .modelContainer(for: Book.self, inMemory: false)

}
