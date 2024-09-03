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
    @IBOutlet weak var completedButton: UIButton!

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
        completedButton.isHidden = project.status == .completed
    }
    
    func setupTasks() {
        guard let project = project else { return }
        for task in project.tasks {
            let namePriceView = TaskNamePriceView(name: task.name, price: "\(Double(task.price)?.formatNumber() ?? "0") $", width: tasksStackView.frame.width)
            tasksStackView.addArrangedSubview(namePriceView)
        }
    }
    
    @IBAction func clickedRemove(_ sender: UIButton) {
        let dialogView = RemoveConfirmationDialog.instanceFromNib()
        dialogView.commonInit(projectName: project?.project.name)
        dialogView.delegate = self
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first {
            dialogView.frame = window.bounds
            window.addSubview(dialogView)
        }
    }
    
    @IBAction func clickedCompleted(_ sender: UIButton) {
        let dialogView = RemoveConfirmationDialog.instanceFromNib()
        dialogView.commonInit(projectName: project?.project.name, isRemove: false)
        dialogView.delegate = self
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first {
            dialogView.frame = window.bounds
            window.addSubview(dialogView)
        }
    }
    
    @IBAction func clickedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProjectViewController: RemoveConfirmationDialogDelegate {
    func completeProject() {
        if let project = project {
            ProjectViewModel.shared.completedProject(with: project)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func removeProject() {
        if let project = project {
            ProjectViewModel.shared.removeProject(with: project)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
