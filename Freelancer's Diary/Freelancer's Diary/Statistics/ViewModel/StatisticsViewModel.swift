//
//  StatisticsViewModel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 29.08.24.
//

import Foundation

class StatisticsViewModel {
    @Published var totalpPrice: String = "0$"
    @Published var totalCompleted: String = "0"
    @Published var totalClients: String = "0"
    
    init() {
        loadProjectsFromUserDefaults()
        loadClientsFromUserDefaults()
    }
    
    func loadProjectsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: .projects),
           let decodedProjects = try? JSONDecoder().decode([ProjectModel].self, from: data) {
            totalpPrice = getTotalPrice(projects: decodedProjects)
            totalCompleted = getTotalCompletedCount(projects: decodedProjects)
        }
    }
    
    func loadClientsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: .clients),
           let decodedClients = try? JSONDecoder().decode([ClientModel].self, from: data) {
            totalClients = "\(decodedClients.count)"
        }
    }
    
    
    func getTotalPrice(projects: [ProjectModel]) -> String {
        let price = projects.reduce(0) { $0 + (Double($1.getTotalPrice())) }.formatNumber()
        return "\(price) $"
    }
    
    func getTotalCompletedCount(projects: [ProjectModel]) -> String {
        return "\(projects.filter({ $0.status == .completed }).count)"
    }
    
}
