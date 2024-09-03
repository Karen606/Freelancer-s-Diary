//
//  StatisticsViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import UIKit
import Combine

class StatisticsViewController: UIViewController {
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var completedNumberLabel: UILabel!
    @IBOutlet weak var clientsNumberLabel: UILabel!
    private let viewModel = StatisticsViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Statistics", button: nil)
        bindPrice()
        bindCompleted()
        bindClients()
        totalPriceLabel.text = viewModel.totalpPrice
        completedNumberLabel.text = viewModel.totalCompleted
        clientsNumberLabel.text = viewModel.totalClients
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadData()
    }
    
    private func bindPrice() {
        viewModel.$totalpPrice
            .receive(on: DispatchQueue.main)
            .sink { [weak self] price in
                self?.totalPriceLabel.text = price
            }
            .store(in: &cancellables)
    }
    
    private func bindCompleted() {
        viewModel.$totalCompleted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completedCount in
                self?.completedNumberLabel.text = completedCount
            }
            .store(in: &cancellables)
    }
    
    private func bindClients() {
        viewModel.$totalClients
            .receive(on: DispatchQueue.main)
            .sink { [weak self] clientsCount in
                self?.clientsNumberLabel.text = clientsCount
            }
            .store(in: &cancellables)
    }
    
}
