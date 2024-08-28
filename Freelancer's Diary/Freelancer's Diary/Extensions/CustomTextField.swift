//
//  CustomTextField.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import UIKit

class CustomTextField: UITextField {
    private var padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 14)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(named: "SelectionColor")
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )

    }
}
