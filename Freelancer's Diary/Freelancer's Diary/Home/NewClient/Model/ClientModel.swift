//
//  ClientModel.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import Foundation

struct ClientModel: Codable {
    var name: String = ""
    var description: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var isRegularCustomer: Bool?
}
