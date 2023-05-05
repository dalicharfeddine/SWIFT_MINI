//
//  UserProfile.swift
//  CarLovers
//
//  Created by DaliCharf on 22/3/2023.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel = ProfileViewModel()
    @State private var showingMatches = false
    @State private var showingEvents = false
    @State private var showingUpdateProfileView = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5){
            Button(action: {
                logout()
            }) {
                Image(systemName: "power")
                    .foregroundColor(.black)
                    .font(.system(size: 14))
            }
            .padding(5)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .alignmentGuide(.trailing) { _ in
                10
            }

            HStack {
                Image("bmw")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                VStack(alignment: .leading, spacing: 5) {
                    if let username = viewModel.user?.username {
                        Text(username)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    HStack(spacing: 10) {
                        Text("Likes: 10")
                            .foregroundColor(.gray)
                        Text("Matches: 5")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading)
            }
            .padding(40)

            
            Button(action: {
                           viewModel.fetchUser()
                           showingUpdateProfileView = true
                       }, label: {
                           Text("Update Profile")
                               .foregroundColor(.white)
                               .font(.system(size: 20))
                       })
                       .sheet(isPresented: $showingUpdateProfileView) {
                           UpdateProfile(viewModel: viewModel)
                       }
                       .frame(maxWidth: .infinity)
                       .frame(height: 50)
                       .background(Color.gray.opacity(0.6))
                       .clipShape(RoundedRectangle(cornerRadius: 30))
            Spacer();

            // Match and Event buttons
            HStack(spacing: 20) {
                Button(action: {
                    showingMatches.toggle()
                }, label: {
                    Text("See Matches")
                        .foregroundColor(.white)
                        .font(.headline)
                })
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.purple)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button(action: {
                    showingEvents.toggle()
                }, label: {
                    Text("See Events")
                        .foregroundColor(.white)
                        .font(.headline)
                })
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.purple)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
        
        .sheet(isPresented: $showingMatches, content: {
            MatchView(user:viewModel.user!)
        })
        .sheet(isPresented: $showingEvents, content: {
            EventView()
        })
        .onAppear {
            viewModel.fetchUser()
            viewModel.fetchUser()
        }
        Spacer()



      
}
    private func logout() {
        // Remove the saved user information
        UserDefaults.standard.removeObject(forKey: "accessToken")

        // Present the login view wrapped in a NavigationView
        let loginView = LoginPage()
        let loginViewWithNavigation = NavigationView { loginView }
        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: loginViewWithNavigation)

        // Dismiss the current view
        dismiss()
    }

    private func dismiss() {
        // Dismiss the view
        presentationMode.wrappedValue.dismiss()
    }
}



struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
