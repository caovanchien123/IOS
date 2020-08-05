//
//  DangNhapViewController.swift
//  IOS
//
//  Created by x_x on 8/5/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import UIKit

class DangNhapViewController: UIViewController {

    @IBOutlet weak var edt_TaiKhoan: UITextField!
    @IBOutlet weak var edt_MatKhau: UITextField!
    //khai bao db
    let db = UserDB()
    
    @IBAction func DangNhapAction(_ sender: Any) {
        let user = db.checkLogin(s_TaiKhoan: edt_TaiKhoan.text ?? "", s_MatKhau: edt_MatKhau.text ?? "")
        if user == nil {
            print("Khong tim thay thong tin tai khoan")
            Toast("Tài khoản hoặc mật khẩu không chính xác").show(self)
        }else{
            chuyenManHinh()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func chuyenManHinh() {
        let src = (storyboard?.instantiateViewController(withIdentifier: "src_Main"))!
        self.present(src, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ViewController else {
            return
        }
        
        viewController.b_TrangThai = true
        viewController.user = db.checkLogin(s_TaiKhoan: edt_TaiKhoan.text ?? "", s_MatKhau: edt_MatKhau.text ?? "")
    }
}
