//
//  NewProjectViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import UIKit

class NewProjectViewController: UIViewController {
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    private let nextButton = UIButton()
    private var selectedPriority: UIButton? {
        didSet {
            if oldValue != selectedPriority {
                selectedPriority?.isSelected = true
                oldValue?.isSelected = false
            }
        }
    }
    private var selectedDifficulty: UIButton? {
        didSet {
            if oldValue != selectedDifficulty {
                selectedDifficulty?.isSelected = true
                oldValue?.isSelected = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Add a new project", button: nextButton)
        nextButton.addTarget(self, action: #selector(clickedNextButton), for: .touchUpInside)
    }

    
    @objc func clickedNextButton() {
        let tasksVC = TasksViewController(nibName: "TasksViewController", bundle: nil)
        self.navigationController?.pushViewController(tasksVC, animated: true)
    }
    
    @IBAction func clickedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func choosePriority(_ sender: UIButton) {
        selectedPriority = sender
    }
    
    @IBAction func chooseDifficulty(_ sender: UIButton) {
        selectedDifficulty = sender
    }
}

