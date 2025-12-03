//
//  ProfileView.swift
//  CPSC357FirebaseDemo
//
//  Created by Luc Rieffel on 12/2/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @ObservedObject var authViewModel = AppEnvironment.shared.authViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Text("Welcome!")
                .font(.title2)
                .foregroundColor(.gray)
            
            if let user = authViewModel.currentUser {
                Text(user.fullname)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else if let email = authViewModel.userSession?.email {
                Text(email)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            Button {
                authViewModel.signOut()
            } label: {
                Text("Sign Out")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
