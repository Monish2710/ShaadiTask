//
//  ContentView.swift
//  Shaadi iOS Task
//
//  Created by Monish Kumar on 28/01/25.
//

import CoreData
import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            ScrollView { // Use ScrollView for custom layout
                VStack(spacing: 16) { // Spacing between cards
                    ForEach(viewModel.users, id: \.name) { user in
                        UserCardView(user: user)
                            .environmentObject(viewModel)
                    }
                }
                .padding(.vertical, 20) // Top and bottom padding
            }
            .background(Color(.systemGroupedBackground)) // Background for the list
            .navigationTitle("Profile Matches")
            .onAppear {
                viewModel.loadUsers()
            }
        }
    }
}

struct UserCardView: View {
    let user: UserDomainModel
    @EnvironmentObject var viewModel: UserViewModel
    @State private var isAccepted: Bool
    @State private var isDeclined: Bool

    init(user: UserDomainModel) {
        self.user = user
        _isAccepted = State(initialValue: user.isAccepted)
        _isDeclined = State(initialValue: user.isDeclined)
    }

    var body: some View {
        VStack(spacing: 16) {
            // Centered Profile Image
            CachedAsyncImage(url: user.profilePictureURL)
                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)

            // User Details
            VStack(spacing: 8) {
                Text(user.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text(user.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }

            // Action Buttons with animation
            if !isAccepted && !isDeclined {
                HStack(spacing: 16) {
                    Button(action: {
                        withAnimation {
                            isAccepted = true
                            isDeclined = false
                            viewModel.acceptUser(user: user)
                        }
                    }) {
                        Text("Accept")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: {
                        withAnimation {
                            isDeclined = true
                            isAccepted = false
                            viewModel.declineUser(user: user)
                        }
                    }) {
                        Text("Decline")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            } else {
                // Show Accepted or Declined Label
                if isAccepted {
                    Text("Accepted")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .transition(.opacity)
                } else if isDeclined {
                    Text("Declined")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .transition(.opacity)
                }
            }
        }
        .padding(16) // Card content padding
        .frame(maxWidth: .infinity)
        .background(Color.white) // Card background
        .cornerRadius(12) // Rounded corners
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4) // Shadow effect
        .padding(.horizontal, 20) // Outer horizontal padding
    }
}
