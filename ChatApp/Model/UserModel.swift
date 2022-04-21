//
//  UserModel.swift
//  ChatApp
//
//  Created by PHONG on 21/04/2022.
//

import Foundation

struct UserModel: Identifiable, Decodable {
    
    var id: String
    
    var createdAt: String
    
    var name: String
    
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case password
        case createdAt
    }
}
