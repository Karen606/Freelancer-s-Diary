//
//  proce.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 04.09.24.
//

import UIKit

class TaskNamePriceView: UIView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.textAlignment = .right
        label.numberOfLines = 1
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    private var width: CGFloat = 0
    
    init(name: String, price: String, width: CGFloat) {
        super.init(frame: .zero)
        setupView(name: name, price: price, width: width)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(name: "", price: "", width: 0)
    }
    
    private func setupView(name: String, price: String, width: CGFloat) {
        addSubview(nameLabel)
        addSubview(priceLabel)
        self.width = width
        self.backgroundColor = UIColor(named: "ButtonColor")
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        nameLabel.text = name
        nameLabel.sizeToFit()
        priceLabel.text = price
        if isTextSingleLine(for: nameLabel) {
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                nameLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8)
            ])
        } else {
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
                priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
        }
    }
    
    private func isTextSingleLine(for label: UILabel) -> Bool {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: label.bounds.height)
        let boundingBox = label.text?.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font ?? 0], context: nil)
        return (width - 24) >= boundingBox?.width ?? 0
    }
}
