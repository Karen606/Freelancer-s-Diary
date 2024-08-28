//
//  SelectClientViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import UIKit
import Combine

class SelectClientViewController: UIViewController {
    @IBOutlet weak var clientsTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var emptyClientsView: UIView!
    private var viewModel = ClientListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Select a client", button: nil)
        setupTableView()
        bindViewModel()
    }
    
    func setupTableView() {
        clientsTableView.delegate = self
        clientsTableView.dataSource = self
        clientsTableView.register(UINib(nibName: "ClientTableViewCell", bundle: nil), forCellReuseIdentifier: "ClientTableViewCell")
    }
    
    private func bindViewModel() {
        viewModel.$clients
            .receive(on: DispatchQueue.main)
            .sink { [weak self] clients in
                self?.updateUI(for: clients)
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(for clients: [ClientModel]) {
        emptyClientsView.isHidden = !clients.isEmpty
        self.clientsTableView.reloadData()
    }
    
    @IBAction func clickedAddButton(_ sender: UIButton) {
        let newClientVC = NewClientViewController(nibName: "NewClientViewController", bundle: nil)
        self.navigationController?.pushViewController(newClientVC, animated: true)
    }
    
    @IBAction func clickedBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelectClientViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientTableViewCell", for: indexPath) as! ClientTableViewCell
        cell.setupData(client: viewModel.clients[indexPath.section])
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
        ProjectViewModel.shared.client = viewModel.clients[indexPath.section]
        ProjectViewModel.shared.saveProjectToUserDefaults()
        ProjectViewModel.shared.clear()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

