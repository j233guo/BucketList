//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Jiaming Guo on 2022-10-16.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
