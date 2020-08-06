//
//  ViewController.swift
//  IOS
//
//  Created by x_x on 8/5/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    //Khai bao bien
    @IBOutlet weak var txt_UserName: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addBackground(color: .white)
        loadData()
    }
    
    private func loadData(){
        if Config.user != nil {
            txt_UserName.text = "Xin chào " + (Config.user?.s_HoTen ?? "") + " (^_^)"
        }
    }
    
}
