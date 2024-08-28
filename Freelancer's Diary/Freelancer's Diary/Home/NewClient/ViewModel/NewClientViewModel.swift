//
//  NewClientViewModel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import Foundation

class NewClientViewModel {
    @Published var newClient = ClientModel()
    
    var isFormValid: Bool {
        !newClient.name.isEmpty &&
        !newClient.description.isEmpty &&
        !newClient.phoneNumber.isEmpty &&
        !newClient.email.isEmpty &&
        newClient.isRegularCustomer != nil
    }
    
    func saveClientToUserDefaults() {
        var clients: [ClientModel] = []
        if let data = UserDefaults.standard.data(forKey: .clients),
           let decodedProjects = try? JSONDecoder().decode([ClientModel].self, from: data) {
            clients = decodedProjects
        }
        clients.append(newClient)
        if let encodedProjects = try? JSONEncoder().encode(clients) {
            UserDefaults.standard.set(encodedProjects, forKey: .clients)
        }
    }
}
