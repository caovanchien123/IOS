//
//  StoryDB.swift
//  IOS
//
//  Created by x_x on 8/5/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import Foundation
import os
import UIKit

class StoryDB {
    let dPath:String
    let DB_NAME: String = "Lon.sqlite"
    let db: FMDatabase?
    
    let TABLE_NAME: String = "story"
    let TABLE_ID: String = "_id"
    let STORY_NAME: String = "name"
    let STORY_CONTENT: String = "content"
    let STORY_CATEGORY: String = "category"
    let STORY_INTRODUCE: String = "introduce"
    let STORY_AUTHOR: String = "author"
    let STORY_IMAGE: String = "image"
    
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
            let sql = "CREATE TABLE " + TABLE_NAME + "( " + TABLE_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " + STORY_NAME + " TEXT, " + STORY_IMAGE + " TEXT, " + STORY_CONTENT + " TEXT, " + STORY_INTRODUCE + " TEXT, " + STORY_AUTHOR + " TEXT, " + STORY_CATEGORY + " TEXT)"
            if db!.executeStatements(sql) {
                ok = true
                os_log("Table is created story")
            }
            else {
                os_log("Can not create the table Story")
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
    
    func insert(story: Story){
        if db != nil {
            let imageData: NSData = story.hinh!.pngData()! as NSData
            let storyImageString = imageData.base64EncodedData(options: .lineLength64Characters)
            let sql = "INSERT INTO " + TABLE_NAME + "(" + STORY_NAME + ", " + STORY_IMAGE + ", " + STORY_CONTENT + ", " + STORY_AUTHOR + ", " + STORY_INTRODUCE + ", " + STORY_CATEGORY  + ")" + " VALUES (?, ?, ?, ?, ?, ?)"
            if(db!.executeUpdate(sql, withArgumentsIn: [story.ten, storyImageString, story.noiDung, story.tacGia, story.gioiThieu, story.theLoai])){
                os_log("the story insert in database")
            }else {
                os_log("Fail to insert the story")
            }
        } else {
            os_log("Database is nil")
        }
    }
    
    func getAllTruyen(storys: inout [Story]){
        if db != nil {
            storys.removeAll()
            let query = "SELECT * FROM story"
            do{
                let result = try db!.executeQuery(query, values: nil)
                while result.next(){
                    let content = result.string(forColumn: STORY_CONTENT)!
                    let introduce = result.string(forColumn: STORY_INTRODUCE)!
                    let category = result.string(forColumn: STORY_CATEGORY)!
                    let author = result.string(forColumn: STORY_AUTHOR)!
                    let name = result.string(forColumn: STORY_NAME)!
                    let imageString = result.string(forColumn: STORY_IMAGE)!
                    let dataImage: Data = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters)!
                    let storyImage = UIImage(data: dataImage)
                    
                    
                    let story = Story(noiDung: content, gioiThieu: introduce, theLoai: category, tacGia: author, ten: name, hinh: storyImage!)
                    storys.append(story)
                }
            }catch{
                
            }
        } else {
            os_log("Database is nil")
        }
    }
}

