//
//  TasksViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import UIKit
import Combine

class TasksViewController: UIViewController {

    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    private var viewModel = TaskListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Tasks", button: nextButton)
        nextButton.addTarget(self, action: #selector(clickedNextButton), for: .touchUpInside)
        setupTableView()
        bindViewModel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setupTableView() {
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }
    
    private func bindViewModel() {
        viewModel.$tasks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tasks in
                let totalPrice = tasks.reduce(0) { $0 + (Int($1.price) ?? 0) }
                self?.totalPriceLabel.text = "Total income: \(totalPrice)$"
                if tasks.count != self?.viewModel.previousTasksCount {
                    self?.updateUI()
                    self?.viewModel.previousTasksCount = tasks.count
                }
                let isValid = !tasks.contains(where: { $0.name.isEmpty || $0.price.isEmpty })
                self?.addButton.isEnabled = isValid
                self?.nextButton.isEnabled = isValid
            }
            .store(in: &cancellables)
    }
    
    func updateUI() {
        tasksTableView.reloadData()
        let indexPath = IndexPath(row: 0, section: viewModel.tasks.count - 1)
        tasksTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    @objc func clickedNextButton() {
        ProjectViewModel.shared.tasks = viewModel.tasks
        let selectClientVC = SelectClientViewController(nibName: "SelectClientViewController", bundle: nil)
        self.navigationController?.pushViewController(selectClientVC, animated: true)
    }

    @IBAction func clickedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedAddButton(_ sender: UIButton) {
        viewModel.clickedAdd()
    }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        
        cell.setupData(task: viewModel.tasks[indexPath.section], number: indexPath.section + 1)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24
    }
    
}

extension TasksViewController: TaskTableViewCellDelegate {
    func changeName(value: String, index: Int) {
        viewModel.updateTaskName(value, at: index)
    }
    
    func changePrice(value: String, index: Int) {
        viewModel.updateTaskPrice(value, at: index)
    }
    func updateTask(task: TaskModel, index: Int) {
        viewModel.updateTask(at: index, with: task)
    }
}

extension TasksViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
