//
//  UserDB.swift
//  IOS
//
//  Created by x_x on 8/5/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import Foundation
import UIKit
import os.log

class MyDatabaseAccess {
    let dPath:String
    let DB_NAME: String = "Story.sqlite"
    let db: FMDatabase?
    
    let TABLE_NAME: String = "user"
    let TABLE_ID: String = "_id"
    let USER_NAME: String = "name"
    let USER_ACCOUNT: String = "account"
    let USER_PASS: String = "pass"
    let USER_AGE: String = "age"
    let USER_IMAGE: String = "image"
    
    
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
            let sql = "CREATE TABLE " + TABLE_NAME + "( " + TABLE_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " + USER_NAME + " TEXT, " + USER_ACCOUNT + " TEXT, " + USER_PASS + " TEXT, " + USER_AGE + " TEXT, " + USER_IMAGE + " TEXT)"
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
    
    func insert(user: User){
        if db != nil {
            let imageData: NSData = user.img_Avata!.pngData()! as NSData
            let userImageString = imageData.base64EncodedData(options: .lineLength64Characters)
            let sql = "INSERT INTO " + TABLE_NAME + "(" + USER_NAME + ", " + USER_ACCOUNT + ", " + USER_PASS + ", " + USER_AGE + ", " + USER_IMAGE + ")" + " VALUES (?, ?, ?)"
            if(db!.executeUpdate(sql, withArgumentsIn: [user.s_HoTen, user.s_TaiKhoan, user.s_MatKhau, user.s_Tuoi, userImageString])){
                os_log("the meal insert in database")
            }else {
                os_log("Fail to insert the meal")
            }
        } else {
            os_log("Database is nil")
        }
    }
    
    func readMealList(users:inout [User]){
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
                    let userName = results!.string(forColumn: USER_NAME) ?? ""
                    let userAccount = results!.string(forColumn: USER_ACCOUNT) ?? ""
                    let userPass = results!.string(forColumn: USER_PASS) ?? ""
                    let userAge = results!.string(forColumn: USER_AGE) ?? ""
                    let string = results!.string(forColumn: USER_IMAGE)
                    let img_Avata: Data = Data(base64Encoded: string!, options: .ignoreUnknownCharacters)!
                    let userAvata = UIImage(data: img_Avata)
                    let user = User(s_TaiKhoan: userAccount, s_MatKhau: userPass, s_HoTen: userName, s_Tuoi: userAge, img_Avata: userAvata)
                    users.append(user)
                }
            }
        } else {
            os_log("Database is nil")
        }
    }
}
