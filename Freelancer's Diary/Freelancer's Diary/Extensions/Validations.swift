//
//  Validations.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 02.09.24.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneRegex = "^\\+\\d \\d{3} \\d{3} \\d{2} \\d{2}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: self)
    }
}
