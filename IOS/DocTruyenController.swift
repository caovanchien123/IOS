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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txt_TenTruyen.text = story?.ten
        txt_NoiDung.text = story?.noiDung
    }

    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
