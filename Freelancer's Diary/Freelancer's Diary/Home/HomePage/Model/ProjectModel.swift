//
//  ProjectModel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import Foundation

struct ProjectModel: Codable, Equatable {
    var project: Project
    var status: ProjectStatus
    var tasks: [TaskModel]
    var client: ClientModel
    var id: UUID
    
    static func == (lhs: ProjectModel, rhs: ProjectModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func getTotalPrice() -> Int {
        return tasks.reduce(0) { $0 + (Int($1.price) ?? 0) }
    }
}

struct Project: Codable {
    var name: String = ""
    var description: String = ""
    var deadline: String = ""
    var priority: Bool?
    var difficulty: Difficulty?
}

enum ProjectStatus: Codable {
    case active
    case completed
}

enum Difficulty: Codable {
    case easy
    case medium
    case hard
    
    var stringValue: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }
}
