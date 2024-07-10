//
//  FileManagerBundle.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/10.
//

import Foundation
extension FileManager {
    static func writeK(d: String, fileName : String){
        
        let data = Data(d.utf8)
        let url = URL.documentsDirectory.appending(path: fileName)

        do {
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
