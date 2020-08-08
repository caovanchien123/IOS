//
//  DocTruyenController.swift
//  IOS
//
//  Created by x_x on 8/6/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import UIKit

class DocTruyenController: UIViewController {

    var story: Story?
    @IBOutlet weak var txt_TenTruyen: UITextField!
    @IBOutlet weak var txt_NoiDung: UITextView!
    @IBOutlet weak var cochu: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txt_TenTruyen.text = story?.ten
        txt_NoiDung.text = story?.noiDung
    }

    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func coChuAction(_ sender: Any) {
        if let coChu1 = cochu.text {
            if coChu1 != "" {
                var i = 14
                if let actualNumber = Int(coChu1) {
                    i = actualNumber
                }
                txt_NoiDung.font = .systemFont(ofSize: CGFloat(i))
            }
        }
    }
}
