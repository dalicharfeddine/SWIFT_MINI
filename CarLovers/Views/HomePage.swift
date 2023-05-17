//
//  HomePage.swift
//  CarKnights
//
//  Created by DaliCharf on 20/3/2023.
//

import SwiftUI

struct HomePage: View {
    @State private var selectedTab: TabBarItem = .house

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedTab) {
                    PostView()
                        .tag(TabBarItem.house)
                    CardStackView()
                        .tag(TabBarItem.person)
                    AddCarView()
                        .tag(TabBarItem.heart)
                    EventList()
                        .tag(TabBarItem.plusCircle)
                    UserProfile()
                        .tag(TabBarItem.profile)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height:700) // Increase the height of the TabView
                .background(Color.white) // set the background of the TabView to white

                HStack(alignment: .bottom) {
                    ForEach(TabBarItem.allCases, id: \.self) { item in
                        TabBarItemView(item: item, isSelected: selectedTab == item) { selected in
                            selectedTab = selected
                        }
                    }
                }
                .padding(.horizontal) // Add some horizontal padding for the tabs
                .background(Color.purple) // set the background of the tab bar to purple
                .cornerRadius(20) // Round the corners of the tab bar
                .shadow(radius: 40) // Add a drop shadow to the tab bar
                .padding() // Add some spacing between the TabView and tab bar
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct TabBarItemView: View {
    let item: TabBarItem
    let isSelected: Bool
    let action: (TabBarItem) -> Void
    
    var body: some View {
        Image(systemName: item.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 35)
            .foregroundColor(isSelected ? .white : Color.white.opacity(0.7)) // set the color of the icon
            .frame(maxWidth: .infinity, maxHeight: 50) // Increase the size of the tabs
            .contentShape(Rectangle()) // Make the entire tab area tappable
            .onTapGesture {
                action(item)
            }
    }
}

enum TabBarItem: String, CaseIterable {
    case house = "house"
    case person = "car"
    case heart = "plus.circle"
    case plusCircle = "map"
    case profile = "person.circle"
    
    var imageName: String {
        self.rawValue
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
