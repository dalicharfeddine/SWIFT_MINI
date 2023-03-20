//
//  SplashScreenView.swift
//  CarKnights
//
//  Created by DaliCharf on 20/3/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
           
                HStack{
                    Image("splashScreen")
                        .resizable()
                      
                        .edgesIgnoringSafeArea(.all)
                                    }
            
            .onAppear {
                // Ajoutez un délai artificiel pour simuler une tâche d'initialisation
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isActive = true
                }
            }
            .fullScreenCover(isPresented: $isActive) {
                // Ajoutez votre page d'accueil ici
                NavigationView {
                    WelcomePage()
                }
            }
        }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
