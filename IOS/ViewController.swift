//
//  ViewController.swift
//  IOS
//
//  Created by x_x on 8/5/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Khai bao bien
    var b_TrangThai = false
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indentifier = segue.identifier {
            switch indentifier {
            case "DangNhap":
                var a = 1
                
            default:
                print("Loi Roi Em")
            }
        }
    }

}

