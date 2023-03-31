//
//  UserProfile.swift
//  CarLovers
//
//  Created by DaliCharf on 22/3/2023.
//

import SwiftUI

struct UserProfile: View {
    @State private var showingMatches = false
    @State private var showingEvents = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 10) {
                // Background image
                Image("bmw")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height * 0.25)
                    .clipped()
                
                // User info section
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image("bmw")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 70, height: 70)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("User Name")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            HStack(spacing: 10) {
                                Text("Likes: 10")
                                    .foregroundColor(.gray)
                                Text("Matches: 5")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.leading)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        // Action for updating profile
                    }, label: {
                        Text("Update Profile")
                            .foregroundColor(.white)
                            .font(.headline)
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .background(Color.white)
                
                Spacer()
            }
            
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
                .background(Color.green)
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
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
        
        .sheet(isPresented: $showingMatches, content: {
            MatchesView()
        })
        .sheet(isPresented: $showingEvents, content: {
            EventsView()
        })
    }
}


struct MatchesView: View {
    var body: some View {
        VStack {
            // List of matched users
            Text("Matches")
                .font(.title)
                .fontWeight(.bold)
            
            List {
                Text("Matched User 1")
                Text("Matched User 2")
                Text("Matched User 3")
            }
            
            // Close button
            Button(action: {
                dismiss()
            }, label: {
                Text("Close")
                    .foregroundColor(.white)
                    .font(.headline)
            })
            .frame(width: 200, height: 50)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
        }
    }
    
    private func dismiss() {
        // Dismiss the matches view
    }
}
struct EventsView: View {
    var body: some View {
        VStack {
            // List of matched users
            Text("Matches")
                .font(.title)
                .fontWeight(.bold)
            
            List {
                Text("EVENT User 1")
                Text("EVENT User 2")
                Text("EVENT User 3")
            }
            
            // Close button
            Button(action: {
                dismiss()
            }, label: {
                Text("Close")
                    .foregroundColor(.white)
                    .font(.headline)
            })
            .frame(width: 200, height: 50)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
        }
    }
    
    private func dismiss() {
        // Dismiss the matches view
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
