//
//  User.swift
//  IOS
//
//  Created by x_x on 8/5/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import Foundation
import UIKit

class User {
    var s_TaiKhoan: String
    var s_MatKhau: String
    var s_HoTen: String
    var s_Tuoi: String
    var ID: String?
    var img_Avata: UIImage?
    
    init(s_TaiKhoan: String, s_MatKhau: String, s_HoTen: String, s_Tuoi: String, img_Avata: UIImage?) {
        self.s_TaiKhoan = s_TaiKhoan
        self.s_MatKhau = s_MatKhau
        self.s_HoTen = s_HoTen
        self.s_Tuoi = s_Tuoi
        self.img_Avata = img_Avata
    }
    
    
}
