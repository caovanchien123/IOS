//
//  Config.swift
//  IOS
//
//  Created by x_x on 8/5/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import Foundation

class Config {
    static let db = UserDB()
    static let truyenDB = StoryDB()
    static var isCheckDB = false
    static var isCheckStoryDB = false
    static var yeuThich = YeuThichDB()
    static var isCheckYeuThichDB = false
    static var b_TrangThai = false
    static var user: User?
}
