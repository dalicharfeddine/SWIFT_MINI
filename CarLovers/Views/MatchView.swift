//
//  MatchView.swift
//  CarLovers
//
//  Created by DaliCharf on 2/5/2023.
//

import SwiftUI

struct MatchView: View {
    @StateObject var viewModel = ContactsListViewModel()
    let userId = UserDefaults.standard.string(forKey: "userId")

    var body: some View {
        NavigationView {

            List(viewModel.contacts, id: \.self) { contact in

                let username = (contact.user1._id == userId) ? contact.user2.username : contact.user1.username
                
                NavigationLink(destination: UserDetailsView(username: username ?? "")) {
                    Text(username ?? "")
                }
            }
            .navigationBarTitle("Match names ")
            .onAppear {
                print("userId: \(userId ?? "nil")")

                viewModel.fetchContacts(userId: userId ?? "") { result in
                    switch result {
                    case .success:
                        break // success
                    case .failure(let error):
                        print("Error fetching contacts: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}



struct UserDetailsView: View {
    let username: String
    @StateObject var viewModel = UserDetailsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = viewModel.user {
                Text("Username")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                Text(user.username)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                Text("Email")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                Text(user.email)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                Text("Phone number")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                Text(String(user.numero))
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
            } else {
                ProgressView()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.purple, .black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .navigationBarTitle("User details", displayMode: .inline)
        .onAppear {
            viewModel.fetchUserDetails(username: username) { result in
                switch result {
                case .success:
                    break // success
                case .failure(let error):
                    print("Error fetching user details: \(error.localizedDescription)")
                }
            }
        }
    }
}


    
    struct MatchView_Previews: PreviewProvider {
        static var previews: some View {
            MatchView()
        }
    }

