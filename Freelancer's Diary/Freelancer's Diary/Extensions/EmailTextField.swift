//
//  EmailTextField.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 02.09.24.
//

import UIKit

class EmailTextField: ValidationTextField, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        emailCommonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        emailCommonInit()
    }
    
    private func emailCommonInit() {
        self.delegate = self
        self.keyboardType = .default
    }
    
    func isValidEmail() {
        self.showError(error: (self.text?.isValidEmail() ?? false) ? nil : "Please enter a valid email address")
    }
}
