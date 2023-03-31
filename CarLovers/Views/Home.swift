//
//  Home.swift
//  CarLovers
//
//  Created by DaliCharf on 21/3/2023.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            ZStack{
                
                Color.red.ignoresSafeArea()
                Text("Home TAB")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            Text("home")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                
                }
            Text("BROWSE TAB")
                .tabItem {
                    Image(systemName: "globe")
                    Text("BROWSE")
                    
                }
            Text("PROFLE TAB")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("profile")
                }
        }
        .accentColor(.purple)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
