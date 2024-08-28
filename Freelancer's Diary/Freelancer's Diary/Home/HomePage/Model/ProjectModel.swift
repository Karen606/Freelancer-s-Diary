//
//  ProjectModel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import Foundation

struct ProjectModel: Codable {
    var project: Project
    var status: ProjectStatus
    var tasks: [TaskModel]
    var client: ClientModel
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
}
