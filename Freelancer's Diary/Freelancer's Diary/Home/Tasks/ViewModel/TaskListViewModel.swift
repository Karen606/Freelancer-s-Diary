//
//  TaskListViewModel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import Foundation

class TaskListViewModel {
    @Published var tasks: [TaskModel] = [TaskModel(name: "", price: "")]
    var previousTasksCount: Int = 0

    var currentTaskIndex: Int?
    
    init() {
        previousTasksCount = tasks.count
    }
    
    func saveProjectsToUserDefaults() {
        if let encodedProjects = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedProjects, forKey: .projects)
        }
    }

    func addTask(_ task: TaskModel) {
        tasks.insert(task, at: 0)
    }
    
    func clickedAdd() {
        tasks.append(TaskModel(name: "", price: ""))
    }
    
    
    
    func updateTaskName(_ name: String, at index: Int) {
        guard index < tasks.count else { return }
        currentTaskIndex = index
        tasks[index].name = name
    }

    func updateTaskPrice(_ price: String, at index: Int) {
        guard index < tasks.count else { return }
        currentTaskIndex = index
        let cleanedPrice = price.components(separatedBy: .whitespaces).joined()
        tasks[index].price = cleanedPrice
    }
    
    func updateTask(at index: Int, with task: TaskModel) {
        guard index < tasks.count else { return }
        tasks[index] = task
    }
}
