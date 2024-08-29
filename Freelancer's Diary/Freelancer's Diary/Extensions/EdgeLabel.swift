//
//  EdgeLabel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 29.08.24.
//

import UIKit

class EdgeLabel: UILabel {
    override open func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
