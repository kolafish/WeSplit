//
//  PicAnnotate.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/13.
//



import SwiftUI
import PhotosUI

struct PicAnnotate: View {
    @State private var viewModel = ViewModel()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack() {
            List(viewModel.pics) { pic in
                NavigationLink(value: pic) {
                    pic.toDisplaySmall()
                }
            }
            .navigationDestination(for: PicAnnotate.ViewModel.PicData.self) { pic in
                pic.toDisplayLarge()
            }
            .navigationTitle("PicAnnotate")
            .toolbar {
                Button("Add Pic", systemImage: "plus") {
                    showingAddExpense = true

                }
            }
            .sheet(isPresented: $showingAddExpense) {
                ttttt899(viewModel : viewModel)
            }
        }
    }
}

struct ttttt899 : View {
    @State private var name = ""
    @State private var selectedItem: PhotosPickerItem?
    var viewModel : PicAnnotate.ViewModel
    @Environment(\.dismiss) var dismiss


    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text:$name)
                    PhotosPicker("Pick a pic", selection: $selectedItem)
                        .buttonStyle(.plain)
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    viewModel.insertPic(selectedItem: selectedItem, name: name)
                    dismiss()
                }

            }
        }
    }
}

#Preview {
    PicAnnotate()
}
