//
//  HomePage.swift
//  CarKnights
//
//  Created by DaliCharf on 20/3/2023.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        Text("Home")
    }
}

struct CarsView: View {
    	
    var body: some View {
        Text("Cars")
    }
}

struct AddView: View {
    var body: some View {
        Text("Add")
    }
}

struct EventView: View {
    var body: some View {
        Text("Event")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile")
    }
}

struct HomePage: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack {
                switch selectedTab {
                case 0:
                    HomeView()
                case 1:
                    CarsView()
                case 2:
                    AddView()
                case 3:
                    EventView()
                case 4:
                    ProfileView()
                default:
                    HomeView()
                }
                
                LoginPage()
                
           
                
                HStack(alignment:.bottom) {
                    NavigationLink(destination: HomeView(),
                                   tag: 0,
                                   selection: Binding<Int?>(
                                                                      get: { self.selectedTab },
                                                                      set: { self.selectedTab = $0 ?? 0 })) {
                        Image(systemName: "house.fill")
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink(destination: CarsView(),
                                   tag: 1,
                                   selection: Binding<Int?>(
                                                                      get: { self.selectedTab },
                                                                      set: { self.selectedTab = $0 ?? 1})) {
                        Image(systemName: "car.fill")
                            .foregroundColor(selectedTab == 1 ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink(destination: AddView(),
                                   tag: 2,
                                   selection: Binding<Int?>(
                                                                      get: { self.selectedTab },
                                                                      set: { self.selectedTab = $0 ?? 2 })) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(selectedTab == 2 ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink(destination: EventView(),
                                   tag: 3,
                                   selection: Binding<Int?>(
                                                                      get: { self.selectedTab },
                                                                      set: { self.selectedTab = $0 ?? 3 })) {
                        Image(systemName: "calendar.circle.fill")
                            .foregroundColor(selectedTab == 3 ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink(destination: ProfileView(),
                                   tag: 4,
                                   selection: Binding<Int?>(
                                                                      get: { self.selectedTab },
                                                                      set: { self.selectedTab = $0 ?? 4})) {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(selectedTab == 4 ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                    }
                }
                .background(Color.white)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

