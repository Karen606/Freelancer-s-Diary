//
//  NewProjectViewModel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import Foundation

class NewProjectViewModel {
    @Published var project = Project()
    
    var isFormValid: Bool {
        !project.name.isEmpty &&
        !project.description.isEmpty &&
        !project.deadline.isEmpty &&
        project.difficulty != nil &&
        project.priority != nil// Assuming difficulty must be set
    }
}
