//
//  ClientListViewModel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import Foundation

class ClientListViewModel {
    @Published var clients: [ClientModel] = []
       
       init() {
           loadClientsFromUserDefaults()
       }

       func loadClientsFromUserDefaults() {
           if let data = UserDefaults.standard.data(forKey: .clients),
              let decodedClients = try? JSONDecoder().decode([ClientModel].self, from: data) {
               clients = decodedClients
           }
       }

       func saveProjectsToUserDefaults() {
           if let encodedClients = try? JSONEncoder().encode(clients) {
               UserDefaults.standard.set(encodedClients, forKey: .clients)
           }
       }

       func addProject(_ client: ClientModel) {
           clients.append(client)
           saveProjectsToUserDefaults()
       }

       func updateProject(at index: Int, with client: ClientModel) {
           guard index < clients.count else { return }
           clients[index] = client
           saveProjectsToUserDefaults()
       }
}
