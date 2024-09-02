//
//  PhoneNumberTextField.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 02.09.24.
//

import UIKit

class PhoneNumberTextField: ValidationTextField, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        phoneNumberCommonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        phoneNumberCommonInit()
    }
    
    private func phoneNumberCommonInit() {
        self.delegate = self
        self.keyboardType = .numberPad
    }
    
    private func format(with mask: String, phoneNumber: String) -> String {
        let numbers = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "x" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+x xxx xxx xx xx", phoneNumber: newString)
        return false
    }
    
    func isValidPhoneNumber() {
        self.showError(error: (text?.isValidPhoneNumber() ?? false) ? nil : "Phone number must be at least 10 numbers")
    }
}
