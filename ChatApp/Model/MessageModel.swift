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
    
}

var testMessage: [MessageModel] = [MessageModel(image: "", name: "", message: "Xin chao"), MessageModel(image: "", name: "Phong", message: "Chao xin"), MessageModel(image: "", name: "", message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry"), MessageModel(image: "", name: "Phong", message: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"), MessageModel(image: "", name: "", message: "Xin chao"), MessageModel(image: "", name: "Phong", message: "Chao xin"), MessageModel(image: "", name: "", message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry"), MessageModel(image: "", name: "Phong", message: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"), MessageModel(image: "", name: "", message: "Xin chao"), MessageModel(image: "", name: "Phong", message: "Chao xin"), MessageModel(image: "", name: "", message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry"), MessageModel(image: "", name: "Phong", message: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"), MessageModel(image: "", name: "", message: "Xin chao"), MessageModel(image: "", name: "Phong", message: "Chao xin"), MessageModel(image: "", name: "", message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry"), MessageModel(image: "", name: "Phong", message: "Last")]
