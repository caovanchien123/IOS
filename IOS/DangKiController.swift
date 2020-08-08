//
//  DangKiController.swift
//  IOS
//
//  Created by x_x on 8/5/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import UIKit

class DangKiController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var img_Hinh: UIImageView?
    @IBOutlet weak var edt_HoTen: UITextField!
    @IBOutlet weak var edt_TaiKhoan: UITextField!
    @IBOutlet weak var edt_MatKhau: UITextField!
    @IBOutlet weak var edt_NhapLaiMatKhau: UITextField!
    @IBOutlet weak var edt_Tuoi: UITextField!
    var checkImage:Bool = false
    
    @IBAction func dangKiAction(_ sender: UIButton) {
        if checkImage && checkForm() {
            let user = User(s_TaiKhoan: edt_TaiKhoan.text!, s_MatKhau: edt_MatKhau.text!, s_HoTen: edt_HoTen.text!, s_Tuoi: edt_Tuoi.text!, img_Avata: img_Hinh?.image)
            Config.db.insert(user: user)
            dismiss(animated: true, completion: nil)
        }else{
            Toast("Lỗi tạo tài khoản").show(self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //create an object of Image Picker
    }
    
    @IBAction func imageClick(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        //Delegation image picker
        imagePicker.delegate = self
        //show the image picker
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //lay anh ve xu ly info
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let  selectedImage = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage  else {
                fatalError("HAHA")
        }
        
        img_Hinh!.image = selectedImage
        checkImage = true
        dismiss(animated: true, completion: nil)
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    private func checkForm() -> Bool {
        if edt_HoTen.text != "", edt_TaiKhoan.text != "", edt_MatKhau.text != "", edt_NhapLaiMatKhau.text != "", edt_Tuoi.text != "" {
            if edt_MatKhau.text == edt_NhapLaiMatKhau.text {
                return true
            }
        }
        return false
    }

}
