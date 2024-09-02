//
//  FormatNumber.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 02.09.24.
//

import Foundation

extension Double {
    func formatNumber() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "fr_FR")
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
