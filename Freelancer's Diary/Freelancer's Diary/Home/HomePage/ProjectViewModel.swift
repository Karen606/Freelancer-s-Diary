//
//  ProjectViewModel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import Foundation

class ProjectViewModel {
    static let shared = ProjectViewModel()
    @Published var projects: [ProjectModel] = []
    var project: Project?
    var tasks: [TaskModel]?
    var client: ClientModel?
    var projectStatus: ProjectStatus? = .active
    
    private init() {
        loadProjectsFromUserDefaults()
    }
    
    func loadProjectsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: .projects),
           let decodedProjects = try? JSONDecoder().decode([ProjectModel].self, from: data) {
            projects = decodedProjects
        }
    }
    
    func saveProjectToUserDefaults() {
        guard let project = project, let tasks = tasks, let client = client, let projectStatus = projectStatus else { return }
        var projects: [ProjectModel] = []
        if let data = UserDefaults.standard.data(forKey: .projects),
               let decodedProjects = try? JSONDecoder().decode([ProjectModel].self, from: data) {
                projects = decodedProjects
            }
            let newProject = ProjectModel(project: project, status: projectStatus, tasks: tasks, client: client)
            projects.append(newProject)
        if let encodedProjects = try? JSONEncoder().encode(projects) {
            UserDefaults.standard.set(encodedProjects, forKey: .projects)
        }
    }
    
    func addProject(_ project: ProjectModel) {
        projects.append(project)
    }

    func updateProject(at index: Int, with project: ProjectModel) {
        guard index < projects.count else { return }
        projects[index] = project
    }
    
    func clear() {
        project = nil
        tasks = nil
        client = nil
        projectStatus = .active
    }
}
