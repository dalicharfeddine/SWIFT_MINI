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
    @State private var showingUpdateProfileView = false
    @State private var showingMatches = false
    @State private var showingEvents = false
    
    var body: some View {
        VStack {
            // Image and Name
            VStack {
                Image("bmw")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding()
                
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
            .padding()
           
            // Edit Profile Button
            Button(action: {
                viewModel.fetchUser()
                showingUpdateProfileView = true
            }, label: {
                Text("Edit Profile")
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
            .padding()
            
            // Matches and Events Buttons
            HStack(spacing: 20) {
                Button(action: {
                    showingMatches.toggle()
                }, label: {
                    VStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                        Text("Matches")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                })
                
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(Color.purple)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button(action: {
                    showingEvents.toggle()
                }, label: {
                    VStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                        Text("Events")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                })
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(Color.purple)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(30)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        
        .sheet(isPresented: $showingMatches, content: {
            if let user = viewModel.user {
                MatchView(user: user)
            } else {
            }
        })
        .sheet(isPresented: $showingEvents, content: {
            EventView()
        })
        .onAppear {
            viewModel.fetchUser()
            viewModel.fetchUser()
        }
        .padding(10)
        Spacer()



      
}
   
}



struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

