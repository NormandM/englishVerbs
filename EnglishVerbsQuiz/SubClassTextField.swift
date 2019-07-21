//
//  SubClassTextField.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-07-12.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit
class TextFieldForCell: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
