//
//  MessageModel.swift
//  ChatApp
//
//  Created by PHONG on 12/04/2022.
//

import Foundation
struct MessageModel: Identifiable, Decodable {
    var id: String = UUID().uuidString
    
    var image: String
    
    var name: String
    
    var message: String
    
    var toId: String
    
}


