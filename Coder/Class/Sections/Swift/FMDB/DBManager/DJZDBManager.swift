//
//  File.swift
//  Coder
//
//  Created by 张得军 on 2019/10/25.
//  Copyright © 2019 张得军. All rights reserved.
//

import Foundation
import FMDB

class DJZDBManager: NSObject {
    
    static let shareManager = DJZDBManager()
    var dbQueue: FMDatabaseQueue?
    override init() {
        super.init()
        openDB()
    }
    private func openDB() {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let userPath = documentDirectory?.stringByAppendingPathComponent(path: "swiftDB")
        if !FileManager.default.fileExists(atPath: userPath!) {
            guard ((try? FileManager.default.createDirectory(atPath: userPath!, withIntermediateDirectories: false, attributes: nil)) != nil) else {
                return
            }
        }
        let fileName = userPath?.stringByAppendingPathComponent(path: "person.db")
        dbQueue = FMDatabaseQueue(path: fileName)
    }
    
    func createTable() {
        let sqlString = "CREATE TABLE IF NOT EXISTS TABLE_LIST('personId' Integer PRIMARY KEY NOT NULL, 'name' Text, 'isTop' Integer)"
        
        DJZDBManager.shareManager.dbQueue?.inDatabase({ (db) in
            db.executeUpdate(sqlString, withArgumentsIn: [])
        })
    }
    
    func dropTable() {
        let sqlString = "DROP TABLE TABLE_LIST"
        DJZDBManager.shareManager.dbQueue?.inDatabase({ (db) in
            db.executeUpdate(sqlString, withArgumentsIn: [])
        })
    }
    
    func insertData(model: DJZDBListModel) {
        let sql = "insert or replace into TABLE_LIST(personId, name, isTop) values (?,?,?)"
        DJZDBManager.shareManager.dbQueue?.inDatabase({ (db) in
            db.executeUpdate(sql, withArgumentsIn: [model.personID, model.name, model.isTop])
        })
    }
    
    func getDataList() -> Array<DJZDBListModel> {
        var resultArray = Array<DJZDBListModel>()
        DJZDBManager.shareManager.dbQueue?.inDatabase({ (db) in
            let sql = "select * from TABLE_LIST order by isTop desc"
            guard let set = try? db.executeQuery(sql, values: []) else {
                return
            }
            while set.next() {
                let model = DJZDBListModel()
                model.personID = Int(set.int(forColumn: "personId"))
                model.name = set.string(forColumn: "name")
                model.isTop = set.bool(forColumn: "isTop")
                resultArray.append(model)
            }
        })
        return resultArray
    }
    
    func deleteDataOfDataList(personId: Int) -> Bool {
        var result: Bool = false
        DJZDBManager.shareManager.dbQueue?.inDatabase({ (db) in
            let sql = "delete from TABLE_LIST where personId = ?"
            result = db.executeUpdate(sql, withArgumentsIn: [personId])
        })
        return result
    }
    
    func setTopWithPersonId(personId: Int, isTop: Bool) -> Bool {
        var result: Bool = false
        DJZDBManager.shareManager.dbQueue?.inDatabase({ (db) in
            let sqlString = "UPDATE TABLE_LIST SET isTop = ? WHERE personId = ?"
            result = db.executeUpdate(sqlString, withArgumentsIn: [isTop, personId])
        })
        return result
    }
}

extension String {
    func stringByAppendingPathComponent(path: String) -> String {
        let nsString = self as NSString
        return nsString.appendingPathComponent(path)
    }
}
