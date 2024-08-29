//
//  ProjectViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 29.08.24.
//

import UIKit

class ProjectViewController: UIViewController {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var tasksStackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var clientLabel: UILabel!
    @IBOutlet weak var clientImageView: UIImageView!
    var project: ProjectModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "My project", button: nil)
        setupData()
        setupTasks()
    }
    
    func setupData() {
        guard let project = project else { return }
        projectNameLabel.text = project.project.name
        priorityLabel.isHidden = !(project.project.priority ?? false)
        descriptionLabel.text = project.project.description
        deadlineLabel.text = project.project.deadline
        difficultyLabel.text = project.project.difficulty?.stringValue
        clientLabel.text = project.client.name
        clientImageView.image = (project.client.isRegularCustomer ?? false) ? UIImage(named: "RegularClient") : UIImage(named: "CustomClient")
    }
    
    func setupTasks() {
        guard let project = project else { return }
        for task in project.tasks {
            let label = EdgeLabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: 50)
            ])
            label.frame.size.height = 50
            label.backgroundColor = UIColor(named: "ButtonColor")
            label.layer.cornerRadius = 12
            label.layer.masksToBounds = true
            label.text = task.name
            label.textColor = .white
            label.font = .systemFont(ofSize: 18, weight: .medium)
            tasksStackView.addArrangedSubview(label)
        }
    }
    
    @IBAction func clickedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
