//
//  DangTruyenController.swift
//  IOS
//
//  Created by x_x on 8/6/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import UIKit
import os

class DangTruyenController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var introduce: MultilineTextField!
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet weak var content: MultilineTextField!
    private var checkImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        load()
    }
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func theTruyen(_ sender: UIBarButtonItem) {
        print("da them roi")
        if checkFrom() && checkImage {
            print("da them roi")
            if Config.truyenDB.open() {
                    Config.truyenDB.insert(story: Story(noiDung: content.text, gioiThieu: introduce.text, theLoai: theLoaiArray[category.selectedRow(inComponent: 0)], tacGia: Config.user!.s_HoTen, ten: name.text!, hinh: image.image!))
                print("da them roi")
            }
        }
    }
    
    private func loadCategory(){
        category.dataSource = self
        category.delegate = self
        category.selectRow(2, inComponent: 0, animated: true)
    }
    
    private func load(){
        
    }
       
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageClick(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        //Delegation image picker
        imagePicker.delegate = self
        //show the image picker
        present(imagePicker, animated: true, completion: nil)
    }
    
    //lay anh ve xu ly info
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let  selectedImage = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage  else {
                fatalError("HAHA")
        }
        
        image!.image = selectedImage
        checkImage = true
        dismiss(animated: true, completion: nil)
    }
    
    private func checkFrom() -> Bool {
        if name.text != "" && content.text != "" && introduce.text != "" {
            return true
        }
        
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return theLoaiArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return theLoaiArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let name = theLoaiArray[row]
        print(name)
    }
    
    let theLoaiArray = ["Truyện cổ grimm", "Truyên cổ Việt Nam", "Truyện cười", "Truyện ma"]

}
