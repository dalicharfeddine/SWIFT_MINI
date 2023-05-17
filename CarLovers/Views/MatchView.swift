//
//  MatchView.swift
//  CarLovers
//
//  Created by DaliCharf on 2/5/2023.
//
import SwiftUI
import MapKit


struct MatchView: View {
    let user : User

    @StateObject var viewModel = ContactsListViewModel()
    let userId = UserDefaults.standard.string(forKey: "userId")

    var body: some View {
        NavigationView {

            List(viewModel.contacts, id: \.self) { contact in

                let username = (contact.user1._id == userId) ? contact.user2.username : contact.user1.username
                
                NavigationLink(destination: UserDetailsView(username: username ?? "", user:user )) {
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
    var user : User
    @StateObject var viewModel = UserDetailsViewModel()
    @State private var region = MKCoordinateRegion()
    
    let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout) {
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
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Text("Phone number")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(String(user.numero))
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Text("Address")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(user.adresse)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                
            }
            .padding()
            Map(coordinateRegion: $region, annotationItems: [user]) { movie in
                MapPin(coordinate: region.center,tint: .red)
            }
            .frame(height: 200)
            .onAppear {
                setRegion()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
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

    private func setRegion() {
        let geocoder = CLGeocoder()
      /*  if let user = viewModel.user {*/

        geocoder.geocodeAddressString(user.adresse) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                return
            }
       
            region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        } }
    }

