//
//  EventView.swift
//  CarLovers
//
//  Created by DaliCharf on 23/3/2023.
//

import SwiftUI

struct JoindreEventView: View {
    var body: some View {
        ZStack {
            Image("eventbackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("EVENT DETAILS")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding(.top, 36)
                
                Image("bmw")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 383, height: 266)
                
                Text("Event: DRIFT Thursday 1st December")
                    .foregroundColor(Color(.systemGray3))
                    .font(.system(size: 25, weight: .bold))
                    .padding(.top, 16)
                
                ScrollView {
                    Text("Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente de feuilles Letraset contenant des passages du Lorem Ipsum, et, plus récemment, par")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .frame(width: 378, height: 210)
                }
                
                Button(action: {
                    // Action to join the event
                }) {
                    Text("join now")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 199, height: 50)
                        .background(Color.white.opacity(0.18))
                        .cornerRadius(25)
                }
                .padding(.top, 16)
                
                Spacer()
            }
        }
    }
}

struct JoindreEventView_Previews: PreviewProvider {
    static var previews: some View {
        JoindreEventView()
    }
}
