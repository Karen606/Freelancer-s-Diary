//
//  ProjectListViewModel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import Foundation

class ProjectListViewModel {
    var projects: [ProjectModel] = []
    @Published var filteredProjects: [ProjectModel] = []
    
    var filterType: ProjectStatus = .active
    
       init() {
           loadProjectsFromUserDefaults()
       }

       func loadProjectsFromUserDefaults() {
           if let data = UserDefaults.standard.data(forKey: .projects),
              let decodedProjects = try? JSONDecoder().decode([ProjectModel].self, from: data) {
               projects = decodedProjects
               filteredProjects = projects.filter({ $0.status == filterType })
           }
       }

       func saveProjectsToUserDefaults() {
           if let encodedProjects = try? JSONEncoder().encode(projects) {
               UserDefaults.standard.set(encodedProjects, forKey: .projects)
           }
       }

       func addProject(_ project: ProjectModel) {
           projects.append(project)
           saveProjectsToUserDefaults()
       }

       func updateProject(at index: Int, with project: ProjectModel) {
           guard index < projects.count else { return }
           projects[index] = project
           saveProjectsToUserDefaults()
       }
    
    func setFilter(type: ProjectStatus) {
        filterType = type
        filteredProjects = projects.filter({ $0.status == filterType })
    }
}
