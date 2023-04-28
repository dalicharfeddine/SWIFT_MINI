//
//  PostView.swift
//  CarLovers
//
//  Created by DaliCharf on 23/3/2023.
//
import SwiftUI

struct PostView: View {
    @State private var isLiked = false
    
    @ObservedObject var PostVieModel = PostViewModel()

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
              
                LazyVStack(alignment:.center)  {
                                ForEach(PostVieModel.posts, id: \.self) { post in
                                    postCell(post:post)
                                    
                    
                                        
                                }
                            }.onAppear{
                                PostVieModel.getPosts()
                            }
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: AddPostPage()) {
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 70, height: 70)
                            .background(Color.purple)
                            .cornerRadius(35)
                            .padding()
                    }
                }
            }
        }
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
