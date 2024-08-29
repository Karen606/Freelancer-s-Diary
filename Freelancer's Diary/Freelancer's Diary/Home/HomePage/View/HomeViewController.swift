//
//  HomeViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    @IBOutlet weak var activeButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var emptyProjectsView: UIView!
    @IBOutlet weak var filterEmptyView: UIView!
    @IBOutlet weak var filterEmptyMessage: UILabel!
    private let viewModel = ProjectListViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Home", button: nil)
        setupTableView()
        bindViewModel()
        activeButton.isSelected = true
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userDefaultsDidChange),
            name: UserDefaults.didChangeNotification,
            object: UserDefaults.standard
        )
    }
    
    func setupTableView() {
        projectsTableView.delegate = self
        projectsTableView.dataSource = self
        projectsTableView.register(UINib(nibName: "ProjectTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectTableViewCell")
    }
    
    private func bindViewModel() {
        viewModel.$filteredProjects
            .receive(on: DispatchQueue.main)
            .sink { [weak self] projects in
                self?.updateUI(for: projects)
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(for projects: [ProjectModel]) {
        if viewModel.projects.isEmpty {
            emptyProjectsView.isHidden = false
            filterEmptyView.isHidden = true
        } else {
            filterEmptyView.isHidden = !projects.isEmpty
            emptyProjectsView.isHidden = true
            filterEmptyMessage.text = viewModel.filterType == .active ? "You have no active projects" : "You have no completed projects"
        }
        self.projectsTableView.reloadData()
    }
    
    @objc private func userDefaultsDidChange(_ notification: Notification) {
        ProjectViewModel.shared.loadProjectsFromUserDefaults()
        viewModel.loadProjectsFromUserDefaults()
        
    }
    
    @IBAction func choseActive(_ sender: UIButton) {
        sender.isSelected = true
        completedButton.isSelected = false
        viewModel.setFilter(type: .active)
    }
    
    @IBAction func chooseCompleted(_ sender: UIButton) {
        sender.isSelected = true
        activeButton.isSelected = false
        viewModel.setFilter(type: .completed)
    }
    
    @IBAction func clickedAddProject(_ sender: UIButton) {
        let addProjectVC = NewProjectViewController(nibName: "NewProjectViewController", bundle: nil)
        self.navigationController?.pushViewController(addProjectVC, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: UserDefaults.standard)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.filteredProjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath) as! ProjectTableViewCell
        cell.setupData(model: viewModel.filteredProjects[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        16
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let projectVC = ProjectViewController(nibName: "ProjectViewController", bundle: nil)
        projectVC.project = viewModel.projects[indexPath.section]
        self.navigationController?.pushViewController(projectVC, animated: true)
    }
}
