//
//  File.swift
//  
//
//  Created by youzy01 on 2020/10/10.
//

import Foundation

public struct File {
    var name: String
    var directory: String
    var extensions: String

    private var manager = FileManager.default

    public init(name: String, extensions: String, inDirectory: String) {
        self.name = name
        self.directory = inDirectory
        self.extensions = extensions
    }

    public func path(for directory: FileManager.SearchPathDirectory) -> String {
        let databaseURL = try! manager.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true)
        let directoryUrl = databaseURL.appendingPathComponent(self.directory, isDirectory: true)
        createFolderIfNotExisits(path: directoryUrl.path)
        let fileUrl = directoryUrl.appendingPathComponent("\(name).\(extensions)")
        return fileUrl.path
    }

    private func createFolderIfNotExisits(path: String) {
        if !manager.fileExists(atPath: path) {
            try? manager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
}
