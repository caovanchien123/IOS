//
//  Story.swift
//  IOS
//
//  Created by x_x on 8/5/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import Foundation
import UIKit

class Story {
    var noiDung:String
    var gioiThieu:String
    var theLoai:String
    var tacGia:String
    var ten:String
    var hinh:UIImage?
    
    init(noiDung:String, gioiThieu:String, theLoai:String, tacGia:String, ten:String, hinh:UIImage) {
        self.noiDung = noiDung
        self.gioiThieu = gioiThieu
        self.theLoai = theLoai
        self.tacGia = tacGia
        self.ten = ten
        self.hinh = hinh
    }
}
