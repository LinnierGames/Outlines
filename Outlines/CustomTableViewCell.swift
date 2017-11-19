//
//  CustomTableViewCell.swift
//  Outlines
//
//  Created by Erick Sanchez on 11/18/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldDoubleTap: UITextField! {
        didSet {
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
            doubleTap.numberOfTapsRequired = 2
            textFieldDoubleTap.isUserInteractionEnabled = false
            self.addGestureRecognizer(doubleTap)
        }
    }
    
    @objc private func doubleTapped() {
        textFieldDoubleTap.isUserInteractionEnabled = true
        textFieldDoubleTap.becomeFirstResponder()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layoutMargins.left = CGFloat(self.indentationLevel) * self.indentationWidth
        self.contentView.layoutIfNeeded()
    }
    
}
