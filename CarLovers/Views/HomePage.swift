//
//  HomePage.swift
//  CarKnights
//
//  Created by DaliCharf on 20/3/2023.
//

import SwiftUI



struct HomePage: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedTab) {
                    PostView()
                        .tag(0)
                    CardStackView()
                        .tag(1)
                    AddCarView()
                        .tag(2)
                    EventList()
                        .tag(3)
                    UserProfile()
                        .tag(4)
                }

                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(alignment: .bottom) {
                    Tab(imageName: "house.fill", tag: 0, selectedTab: $selectedTab)
                    Tab(imageName: "car.fill", tag: 1, selectedTab: $selectedTab)
                    Tab(imageName: "plus.circle.fill", tag: 2, selectedTab: $selectedTab)
                    Tab(imageName: "calendar.circle.fill", tag: 3, selectedTab: $selectedTab)
                    Tab(imageName: "person.crop.circle.fill", tag: 4, selectedTab: $selectedTab)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct Tab: View {
    let imageName: String
    let tag: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Image(systemName: imageName)
            .foregroundColor(selectedTab == tag ? .blue : .gray)
            .frame(maxWidth: .infinity)
            .onTapGesture {
                selectedTab = tag
            }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
