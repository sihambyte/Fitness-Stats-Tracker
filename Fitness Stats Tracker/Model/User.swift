//
//  User.swift
//  Fitness Stats Tracker
//
//  Created by siham on 11/11/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    var initials:String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User{
    static var Mock_USER = User(id:NSUUID().uuidString, fullname: "Siham Argaw", email: "test@gmail.com")
}
