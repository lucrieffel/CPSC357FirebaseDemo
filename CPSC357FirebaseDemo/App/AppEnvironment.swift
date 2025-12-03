//
//  AppEnvironment.swift
//  CPSC357FirebaseDemo
//
//  Created by Luc Rieffel on 12/3/25.
//

import Foundation
import Combine

// MARK: - App Environment
// Centralized container for all ViewModels
@MainActor
class AppEnvironment: ObservableObject {
    static let shared = AppEnvironment()
    
    let authViewModel = AuthViewModel()
}
