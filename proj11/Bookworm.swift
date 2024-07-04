//
//  Bookworm.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/4.
//

import SwiftUI
import SwiftData


struct Bookworm: View {
//    @Query(sort: \Book.title) var books: [Book]
//    @Query(sort: \Book.rating, order: .reverse) var books: [Book]
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]


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
                                    .foregroundStyle(book.rating == 1 ? .red : .primary)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
               .toolbar {
                   ToolbarItem(placement: .topBarTrailing) {
                       Button("Add Book", systemImage: "plus") {
                           showingAddScreen.toggle()
                       }
                   }
                   ToolbarItem(placement: .topBarLeading) {
                       EditButton()
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
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our query
            let book = books[offset]

            // delete it from the context
            modelContext.delete(book)
        }
    }
}

#Preview {
    Bookworm()
        .modelContainer(for: Book.self, inMemory: false)

}
