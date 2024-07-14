//
//  PicAnnotateViewModel.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/13.
//

import Foundation
import PhotosUI
import SwiftUI

extension PicAnnotate {
    @Observable
    class ViewModel {
        
        struct PicData : Comparable, Codable, Equatable, Identifiable, Hashable{
            var id : UUID
            var picData : Data
            var name :String
            
            static func ==(lhs: PicData, rhs: PicData) -> Bool {
                lhs.name == rhs.name
            }
            static func < (lhs: PicData, rhs: PicData) -> Bool {
                lhs.name < rhs.name
            }
            init(picData: Data, name : String) {
                self.id = UUID()
                self.picData = picData
                self.name = name
            }
            
            func toDisplaySmall() -> some View{
                VStack {
                    Text(self.name)
                    Image(uiImage: UIImage(data: self.picData )!)
                        .resizable()
                        .frame(width: 104, height: 72)
                        .clipShape(.capsule)
                        .overlay(
                            Capsule()
                                .strokeBorder(.white, lineWidth: 1)
                        )
                }
            }
            func toDisplayLarge() -> some View{
                VStack {
                    Text(self.name)
                    Image(uiImage: UIImage(data: self.picData )!)
                        .resizable().scaledToFit()
                }
                .background(.darkBackground)
                .navigationTitle(self.name)
            }
        }
        
        var pics  : [PicData]
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")



        init() {
            do {
                let data = try Data(contentsOf: savePath)
                pics = try JSONDecoder().decode([PicData].self, from: data)
            } catch {
                pics = []
            }
        }
        func save() {
            do {
                let data = try JSONEncoder().encode(pics)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }

        func insertPic(selectedItem: PhotosPickerItem?, name :String)  {
            Task {
                guard let d = try await selectedItem?.loadTransferable(type: Data.self) else { return }
                self.pics.append(PicData(picData: d, name:  name))
                save()
            }
        }
        
    }
}

