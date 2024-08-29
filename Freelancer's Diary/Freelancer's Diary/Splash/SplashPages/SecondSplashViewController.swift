//
//  SecondSplashViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import UIKit

class SecondSplashViewController: UIViewController {
    @IBOutlet weak var descriptionlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let description = "Create your first Task, write Down your tasks and goals, set a deadline, and stick to your goals."
        let attributedString = NSMutableAttributedString(string: description)
        if let range = description.range(of: "Task") {
            let taskRange = NSRange(range, in: description)
            attributedString.addAttribute(.foregroundColor, value: UIColor(named: "ButtonColor")?.withAlphaComponent(0.5) ?? .gray, range: taskRange)
        }
        if let range = description.range(of: "Down") {
            let downRange = NSRange(range, in: description)
            attributedString.addAttribute(.foregroundColor, value: UIColor(named: "ButtonColor")?.withAlphaComponent(0.5) ?? .gray, range: downRange)
        }
        descriptionlabel.attributedText = attributedString
    }
}
