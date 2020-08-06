//
//  DangNhapViewController.swift
//  IOS
//
//  Created by x_x on 8/5/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import UIKit

class DangNhapController: UIViewController {

    @IBOutlet weak var edt_TaiKhoan: UITextField!
    @IBOutlet weak var edt_MatKhau: UITextField!
    private var user:User?
    
    @IBAction func DangNhapAction(_ sender: Any) {
        user = Config.db.checkLogin(s_TaiKhoan: edt_TaiKhoan.text ?? "", s_MatKhau: edt_MatKhau.text ?? "")
        if user == nil {
            print("Khong tim thay thong tin tai khoan")
            Toast("Tài khoản hoặc mật khẩu không chính xác").show(self)
        }else{
            edt_MatKhau.text = ""
            edt_TaiKhoan.text = ""
            Config.b_TrangThai = true
            Config.user = user
            chuyenManHinh()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Config.db.open() {
            if !Config.isCheckDB{
                Config.isCheckDB = Config.db.createTable()
            }
        }
        if Config.truyenDB.open() {
            if !Config.isCheckStoryDB {
                Config.isCheckStoryDB = Config.truyenDB.createTable()
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func chuyenManHinh() {
        let src = (storyboard?.instantiateViewController(withIdentifier: "src_Main"))!
        self.present(src, animated: true, completion: nil)
    }
}
