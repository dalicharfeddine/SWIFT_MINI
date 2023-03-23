//
//  PostView.swift
//  CarLovers
//
//  Created by DaliCharf on 23/3/2023.
//
import SwiftUI

struct PostView: View {
    @State private var isLiked = false
    
    var body: some View {
        VStack {
            HStack {
                Text("DAli DAli")
                    .font(.headline)
                    .padding(.leading, 16)
                Spacer()
            }
            
            Rectangle()
                .frame(height: 5)
                .foregroundColor(Color.gray)
            
            HStack {
                Image("bmw")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.leading, 16)
                
                VStack(alignment: .leading) {
                    Text("titre")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .padding(.top, 28)
                        .padding(.leading, 8)
                    Text("description")
                        .font(.subheadline)
                        .foregroundColor(Color.black)
                        .padding(.top, 4)
                        .padding(.leading, 8)
                    
                }
                
                Spacer()
                
                Button(action: {
                    isLiked.toggle()
                }, label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isLiked ? Color.red : Color.black)
                })
                .padding(.trailing, 16)
                .padding(.bottom, 4)
            }
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 3)
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}


