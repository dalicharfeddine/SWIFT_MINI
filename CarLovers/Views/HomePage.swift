//
//  HomePage.swift
//  CarKnights
//
//  Created by DaliCharf on 20/3/2023.
//

import SwiftUI



struct HomePage: View {
    @State private var selectedTab = 5

    var body: some View {
        NavigationView {
            VStack {
                switch selectedTab {
                case 0:
                    PostView()
                case 1:
                    CardStackView()
                case 2:
                    UserProfile()
                case 3:
                    UserProfile()
                case 4:
                    UserProfile()
                default:
                    PostView()
                }
                
                
           
                
                HStack(alignment:.bottom) {
                    NavigationLink(destination: PostView(),
                                   tag: 0,
                                   selection: Binding<Int?>(
                                                   get: { self.selectedTab },
                                                   set: { self.selectedTab = $0 ?? 0 })) {
                        Image(systemName: "house.fill")
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                    }.tag(5)

                    
                    
                    NavigationLink(destination:                             CardStackView()

,
                                   tag: 1,
                                   selection: Binding<Int?>(
                                                                      get: { self.selectedTab },
                                                                      set: { self.selectedTab = $0 ?? 1})) {
                        Image(systemName: "car.fill")
                            .foregroundColor(selectedTab == 1 ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink(destination:                     UserProfile()
,
                                   tag: 2,
                                   selection: Binding<Int?>(
                                                                      get: { self.selectedTab },
                                                                      set: { self.selectedTab = $0 ?? 2 })) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(selectedTab == 2 ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink(destination:                    UserProfile()
,
                                   tag: 3,
                                   selection: Binding<Int?>(
                                                                      get: { self.selectedTab },
                                                                      set: { self.selectedTab = $0 ?? 3 })) {
                        Image(systemName: "calendar.circle.fill")
                            .foregroundColor(selectedTab == 3 ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink(destination:                    UserProfile()
,
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
