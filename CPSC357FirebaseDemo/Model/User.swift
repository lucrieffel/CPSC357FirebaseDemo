//
//  User.swift
//  CPSC357FirebaseDemo
//
//  Created by Luc Rieffel on 12/2/25.
//

import Foundation

// MARK: - User Model
struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    // Initialize from Firestore document data
    init?(from data: [String: Any]) {
        guard
            let id = data["id"] as? String,
            let fullname = data["fullname"] as? String,
            let email = data["email"] as? String
        else {
            return nil
        }
        
        self.id = id
        self.fullname = fullname
        self.email = email
    }
}
