//
//  FriendModel.swift
//  ChatApp
//
//  Created by PHONG on 18/04/2022.
//

import Foundation

struct FriendModel: Identifiable, Decodable {
    var id: String
    
    var name: String
    
    var avatar: String
    
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar
        case createdAt
    }
}
