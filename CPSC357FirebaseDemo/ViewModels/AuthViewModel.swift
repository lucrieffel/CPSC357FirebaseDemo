//
//  AuthViewModel.swift
//  CPSC357FirebaseDemo
//
//  Created by Luc Rieffel on 12/2/25.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

// MARK: - AuthViewModel
@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?  // Firebase auth session
    @Published var currentUser: User?               // Our custom User model
    
    private let db = Firestore.firestore()
    
    init() {
        // Check if user is already logged in
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    // MARK: - Sign In
    func signIn(withEmail email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
        await fetchUser()
    }
    
    // MARK: - Register
    func register(withEmail email: String, password: String, fullname: String) async throws {
        // 1. Create user in Firebase Auth
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        self.userSession = result.user
        
        // 2. Create user document in Firestore
        let userData: [String: Any] = [
            "id": result.user.uid,
            "fullname": fullname,
            "email": email
        ]
        
        try await db.collection("users").document(result.user.uid).setData(userData)
        
        // 3. Fetch the user we just created
        await fetchUser()
    }
    
    // MARK: - Fetch User
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await db.collection("users").document(uid).getDocument(),
              let data = snapshot.data() else { return }
        
        self.currentUser = User(from: data)
    }
    
    // MARK: - Sign Out
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
}
