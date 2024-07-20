//
//  FileManager-Extension.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/7/20.
//

import Foundation
extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
