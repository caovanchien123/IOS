//
//  ExtensionCustomUI.swift
//  IOS
//
//  Created by x_x on 8/6/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UITextField {
    func insertToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Hoàn thành", style: .done, target: self, action: #selector(UIView.endEditing(_:)))
        toolbar.setItems([flexSpace, doneBtn], animated: true)
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }
}

extension UITextView {
    func insertToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Hoàn thành", style: .done, target: self, action: #selector(UIView.endEditing(_:)))
        toolbar.setItems([flexSpace, doneBtn], animated: true)
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }
}

extension UITableView {
    func indexPathForView(view: AnyObject) -> NSIndexPath? {
        let originInTableView = self.convert(CGPoint.zero, from: (view as! UIView))
        return self.indexPathForRow(at: originInTableView)! as NSIndexPath
    }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.alpha = 0.6
        subView.layer.borderWidth = 1.0
        subView.layer.borderColor = UIColor.black.cgColor
        // shadow
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOffset = CGSize(width: 3, height: 3)
        subView.layer.shadowOpacity = 0.9
        subView.layer.shadowRadius = 4.0
        subView.layer.cornerRadius = 20
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
