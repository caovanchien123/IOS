//
//  CustomTableViewCell.swift
//  IOS
//
//  Created by x_x on 8/6/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var img_hinh: UIImageView!
    @IBOutlet weak var txt_TenTruyen: UITextField!
    @IBOutlet weak var txt_TacGia: UITextField!
    @IBOutlet weak var txt_GioiThieu: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
