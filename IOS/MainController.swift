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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let data = segue.destination as? UINavigationController {
            if let data2 = data.viewControllers[0] as? DSYTCTController {
                let id = segue.identifier
                switch id {
                case "id_YeuThich":
                    data2.navigrationDirection = .yeuthich
                case "id_CuaToi":
                    data2.navigrationDirection = .cuatoi
                default:
                    break
            }
        }
        
        
    }
}

}
