//
//  WelcomePage.swift
//  CarKnights
//
//  Created by DaliCharf on 20/3/2023.
//
import SwiftUI


struct WelcomePage: View {
    @State private var isLoginPresented = false
    @State private var isSignInPresented = false


    
    var body: some View {
        ZStack {
            Image("bmw")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                ViewPager()

                HStack {
                  
                    Button(action: {
                        isLoginPresented = true
                    }, label: {
                        Text("LOGIN")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .frame(width: 170, height: 50)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                    })
                    .fullScreenCover(isPresented: $isLoginPresented) {
                        // Ajoutez votre page d'accueil ici
                        NavigationView {
                            LoginPage()
                        }
                    }
                    .padding(.trailing, 8)

                    Button(action: {
                        isSignInPresented=true
                    }, label: {
                        Text("SIGN UP")
                            .foregroundColor(.blue)
                            .font(.system(size: 18))
                            .frame(width: 170, height: 50)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                    })
                    .fullScreenCover(isPresented: $isSignInPresented) {
                        // Ajoutez votre page d'accueil ici
                        NavigationView {
                           SignInPage()
                        }
                    }
                    .padding(.trailing, 10)
                }
                .padding(.bottom,10)
            }
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}

struct ViewPager: View {
    @State private var currentPage = 0

    private let images: [Image] = [Image("welcome1"), Image("welcome2"), Image("welcome3")]

    var body: some View {
        VStack(spacing: 0) {
            
            TabView(selection: $currentPage) {
                ForEach(0..<3) { index in
                    ZStack {
                        images[index]
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .clipped()
                           
                           

                       
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding(.horizontal)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CirclePageControl(numberOfPages: images.count, currentPage: $currentPage)
                .padding(.vertical, 50)
        }
    }
}

/* hedhi li bsh esthakha fel add car (l'interface tatlaa men louta )
    .sheet(isPresented: $isLoginPresented, content: {
        LoginPage()
    })
*/


struct CirclePageControl: View {
    let numberOfPages: Int
    @Binding var currentPage: Int

    private let circleSize: CGFloat = 12
    private let spacing: CGFloat = 8

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<3) { index in
                Circle()
                    .foregroundColor(currentPage == index ? .white : .gray)
                    .frame(width: circleSize, height: circleSize)
            }
        }
        .padding(.top, spacing)
        .padding(.horizontal, spacing * CGFloat(numberOfPages))
        .animation(.easeInOut)
    }
}
