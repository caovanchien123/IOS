//
//  YeuThichDB.swift
//  IOS
//
//  Created by x_x on 8/7/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import Foundation

import UIKit
import os.log

class YeuThichDB {
    let dPath:String
    let DB_NAME: String = "StoryDB1.sqlite"
    let db: FMDatabase?
    
    let TABLE_NAME: String = "yeuthich"
    let TABLE_ID: String = "_id"
    let YEUTHICH_ID_USER: String = "id_user"
    let YEUTHICH_ID_STORY: String = "id_story"
    
    init() {
        let directories:[String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        dPath = directories[0] + "/" + DB_NAME
        db = FMDatabase(path: dPath)
        if db == nil {
            os_log("Can not create the database, please review the dPath!")
        }
        else{
            os_log("Database is created successfull")
        }
    }
    
    func createTable() -> Bool {
        var ok: Bool = false
        if db != nil {
            let sql = "CREATE TABLE " + TABLE_NAME + "( " + TABLE_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " + YEUTHICH_ID_USER + " TEXT, " + YEUTHICH_ID_STORY + " TEXT)"
            if db!.executeStatements(sql) {
                ok = true
                os_log("Table is created")
            }
            else {
                os_log("Can not create the table")
            }
        } else {
            os_log("Database is nil")
        }
        
        return ok
    }
    
    func open() -> Bool {
        var ok: Bool = false
        if db != nil {
            if db!.open() {
                ok = true
                os_log("The database is opened")
            }
            else {
                print("Can not open the Database: \(db!.lastErrorMessage())")
            }
        } else {
            os_log("Database is nil")
        }
        
        return ok
    }
    
    func insert(dadoc: ID){
        if db != nil {
            let sql = "INSERT INTO " + TABLE_NAME + " (" + YEUTHICH_ID_STORY + ", " + YEUTHICH_ID_USER + ")" + " VALUES ( ?, ?)"
            print(sql + dadoc.idTruyen + dadoc.idUser)
            if(db!.executeUpdate(sql, withArgumentsIn: [dadoc.idTruyen, dadoc.idUser])){
                os_log("the meal insert in database")
            }else {
                os_log("Fail to insert the meal")
            }
        } else {
            os_log("Database is nil")
        }
    }
    
    func delete(dadoc: ID){
        if db != nil {
            let sql = "DELETE FROM \(TABLE_NAME) WHERE \(YEUTHICH_ID_STORY) = ? AND \(YEUTHICH_ID_USER) = ?"
            do {
                try db?.executeUpdate(sql,  values: [dadoc.idTruyen, dadoc.idUser])
                os_log("the meal is deleted")
            }
            catch{
                os_log("Fail to delete the meal")
            }
        } else {
            os_log("Database is nil")
        }
    }
    
    func readMealList(story:inout [Story]){
        story.removeAll()
        if db != nil {
            var results: FMResultSet?
            let sql = "SELECT * FROM \(TABLE_NAME)"
            do {
                results = try db?.executeQuery(sql, values: nil)
            }
            catch{
                print("fail to read data:  \(error.localizedDescription)")
            }
            if results != nil {
                while (results?.next())! {
                    story.append(Config.truyenDB.getTruyen(id: (results?.string(forColumn: YEUTHICH_ID_STORY))!)!)
                }
            }
        } else {
            os_log("Database is nil")
        }
    }
    
    func check(story: Story) -> Bool {
        if db != nil {
            var results: FMResultSet?
            let sql = "SELECT * FROM \(TABLE_NAME) WHERE \(YEUTHICH_ID_STORY) = ?"
            do {
                results = try db?.executeQuery(sql, values: [story.ID_Story])
            }
            catch{
                print("fail to read data:  \(error.localizedDescription)")
            }
            if results != nil {
                while (results?.next())! {
                    return false
                }
            }
        } else {
            os_log("Database is nil")
        }
        return true
    }
}
