//
//  FirstSplashViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import UIKit

class FirstSplashViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let description = "The application will help you develop your Projects and monitor statistics"
        let attributedString = NSMutableAttributedString(string: description)
        if let range = description.range(of: "Projects") {
            let nsRange = NSRange(range, in: description)
            attributedString.addAttribute(.foregroundColor, value: UIColor(named: "ButtonColor")?.withAlphaComponent(0.5) ?? .gray, range: nsRange)
        }
        descriptionLabel.attributedText = attributedString
    }
}
