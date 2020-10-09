//
//  Database.swift
//  
//
//  Created by youzy01 on 2020/9/16.
//

import Foundation

//private struct File {
//    var name: String
//    var directory: String
//
//    private var manager = FileManager.default
//
//    init(name: String, directory: String) {
//        self.name = name
//        self.directory = directory
//    }
//
//    func creatPath() -> String {
//        let databaseURL = try! manager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//        let directoryUrl = databaseURL.appendingPathComponent(directory, isDirectory: true)
//        createFolderIfNotExisits(path: directoryUrl.path)
//        let fileUrl = databaseURL.appendingPathComponent("\(name).sqlite")
//        return fileUrl.path
//    }
//
//    private func createFolderIfNotExisits(path: String) {
//        if !manager.fileExists(atPath: path) {
//            try? manager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
//        }
//    }
//}
//
//
///// 请求记录数据库
//struct Database {
//    private let dbQueue: DatabaseQueue
//
//    init(fileName: String, directory: String = "URLRecord") throws {
////        var databaseURL = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
////        databaseURL = databaseURL.appendingPathComponent(directory, isDirectory: true)
////        databaseURL = databaseURL.appendingPathComponent("\(fileName).sqlite")
//        let path = File(name: fileName, directory: directory).creatPath()
//        dbQueue = try! DatabaseQueue(path: path)
//        print(path)
//        try migrator.migrate(dbQueue)
//    }
//
//    /// The DatabaseMigrator that defines the database schema.
//    ///
//    /// See https://github.com/groue/GRDB.swift/blob/master/README.md#migrations
//    var migrator: DatabaseMigrator {
//        var migrator = DatabaseMigrator()
//
//        migrator.registerMigration("v1") { db in
//            // Create a table
//            // See https://github.com/groue/GRDB.swift#create-tables
//            try db.create(table: "Record") { t in
//                t.autoIncrementedPrimaryKey("id")
//                // Sort player names in a localized case insensitive fashion by default
//                // See https://github.com/groue/GRDB.swift/blob/master/README.md#unicode
//                t.column("api", .text).notNull().collate(.localizedCaseInsensitiveCompare)
//                t.column("parameter", .text).collate(.localizedCaseInsensitiveCompare)
//                t.column("date", .date).notNull()
//            }
//        }
//        return migrator
//    }
//}
//
//extension Database {
//    /// 保存请求记录
//    /// - Parameters:
//    ///   - api: 接口path
//    ///   - parameter: 接口参数
//    /// - Throws: 保存数据库引发的错误
//    func saveRecord(_ api: String, parameter: String) throws {
//        var item = Record(api: api, parameter: parameter)
//        try dbQueue.write { db in
//            try item.save(db)
//        }
//    }
//
//    /// 保存请求记录
//    /// - Parameters:
//    ///   - api: 接口path
//    ///   - parameter: 接口参数
//    ///   - date: 接口调用时间
//    /// - Throws: 保存数据库引发的错误
//    func saveRecord(_ api: String, parameter: String, date: Date) throws {
//        var item = Record(api: api, parameter: parameter, date: date)
//        try dbQueue.write { db in
//            try item.save(db)
//        }
//    }
//
//    /// 查询记录数量
//    /// - Parameters:
//    ///   - api: 接口path
//    ///   - parameter: 接口参数
//    ///   - date: 接口请求时间
//    /// - Throws: 查询数据库引发的错误
//    /// - Returns: 符合条件的请求记录数量
//    func queryCount(_ api: String, parameter: String, date: Date) throws -> Int {
//        let apiColumn = Record.Columns.api
//        let parameterColumn = Record.Columns.parameter
//        let dateColumn = Record.Columns.date
//
//        return try dbQueue.read { (db) -> Int in
//            return try Record.filter(apiColumn == api).filter(parameterColumn == parameter).filter(dateColumn > date).fetchCount(db)
//        }
//    }
//
//    /// 查询记录数量
//    /// - Parameters:
//    ///   - api: 接口path
//    ///   - date: 接口请求时间
//    /// - Throws: 查询数据库引发的错误
//    /// - Returns: 符合条件的请求记录数量
//    func queryCount(_ api: String, date: Date) throws -> Int {
//        let apiColumn = Record.Columns.api
//        let dateColumn = Record.Columns.date
//
//        return try dbQueue.read { (db) -> Int in
//            return try Record.filter(apiColumn == api).filter(dateColumn > date).fetchCount(db)
//        }
//    }
//
//    /// 查询记录数量
//    /// - Parameter date: 接口请求时间
//    /// - Throws: 查询数据库引发的错误
//    /// - Returns: 符合条件的请求记录数量
//    func queryCount(_ date: Date) throws -> Int {
//        let dateColumn = Record.Columns.date
//
//        return try dbQueue.read { (db) -> Int in
//            return try Record.filter(dateColumn > date).fetchCount(db)
//        }
//    }
//
//    func delete(where date: Date) {
//        let dateColumn = Record.Columns.date
//
//        try? dbQueue.write { db in
//            _ = try? Record.filter(dateColumn < date).deleteAll(db)
//        }
//    }
//
//    /// 删除全部记录
//    /// - Throws: 删除数据库记录引发的错误
//    func deleteAll() throws {
//        try dbQueue.write { db in
//            _ = try Record.deleteAll(db)
//        }
//    }
//}
//
//private extension Database {
//    struct Record {
//        var id: Int64?
//        var api: String = ""
//        var parameter: String = ""
//        var date: Date = Date()
//
//        init(api: String, parameter: String) {
//            self.api = api
//            self.parameter = parameter
//        }
//
//        init(api: String, parameter: String, date: Date) {
//            self.api = api
//            self.parameter = parameter
//            self.date = date
//        }
//    }
//}
//
//extension Database.Record: Codable, FetchableRecord, MutablePersistableRecord, TableRecord {
//    enum Columns {
//        static let id = Column(CodingKeys.id)
//        static let api = Column(CodingKeys.api)
//        static let parameter = Column(CodingKeys.parameter)
//        static let date = Column(CodingKeys.date)
//    }
//
//    // Update a player id after it has been inserted in the database.
//    mutating func didInsert(with rowID: Int64, for column: String?) {
//        id = rowID
//    }
//}
