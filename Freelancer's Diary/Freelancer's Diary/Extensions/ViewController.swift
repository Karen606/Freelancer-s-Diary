//
//  ViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import UIKit

extension UIViewController {
    func setNavigationBar(title: String, button: UIButton?) {
        if let nextButton = button {
            nextButton.setTitle("Next", for: .normal)
            nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
            nextButton.setTitleColor(.white.withAlphaComponent(0.5), for: .disabled)
            nextButton.setTitleColor(.white, for: .normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton)
        }
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor(named: "ButtonColor")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    @objc func clickedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }
}
