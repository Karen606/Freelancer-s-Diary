//
//  ClientsViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import UIKit
import Combine

class ClientsViewController: UIViewController {
    @IBOutlet weak var clientsTableView: UITableView!
    private let viewModel = ClientListViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Clients", button: nil)
        setupTableView()
        bindViewModel()
        // Do any additional setup after loading the view.
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
                self?.clientsTableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension ClientsViewController: UITableViewDelegate, UITableViewDataSource {
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
        
    }
}


