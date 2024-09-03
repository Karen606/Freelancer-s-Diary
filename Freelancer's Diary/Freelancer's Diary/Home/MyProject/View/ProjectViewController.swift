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
            let namePriceView = NamePriceView(name: task.name, price: "\(Double(task.price)?.formatNumber() ?? "0") $", width: tasksStackView.frame.width)
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

class NamePriceView: UIView {
    
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
