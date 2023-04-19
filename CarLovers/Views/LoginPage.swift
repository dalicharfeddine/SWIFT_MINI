////
//  LoginPage.swift
//  CarKnights
//
//  Created by DaliCharf on 20/3/2023.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginViewModel = LoginViewModel()
    
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var loginSuccess = false
    @State var redirectToHomePage = false
    @State private var isForgotPasswordLinkTapped = false


    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("bmw")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    VStack(){
                        Image("logocarknights")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:250, height: 250)
                    }
                    
                    
                    VStack(spacing: 20) {
                        TextField("Username", text: $email)
                            .padding()
                            .background(Color.gray.opacity(0.9))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .font(.system(size: 16, weight: .medium))
                            .textContentType(.name)
                        
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                                    .padding()
                                    .background(Color.gray.opacity(0.9))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                    .accentColor(.white)
                                    .font(.system(size: 16, weight: .medium))
                                    .textContentType(.name)
                            } else {
                                SecureField("Password", text: $password)
                                    .padding()
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                    .accentColor(.white)
                                    .font(.system(size: 16, weight: .medium))
                                    .textContentType(.name)
                            }
                            Button(action: {
                                isPasswordVisible.toggle()
                            }, label: {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.secondary)
                            })
                            .padding(.trailing, 8)
                        }
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.3))).frame(height: 50)
                    }
                    .padding(.horizontal, 50)
                    
                    Button(action: {
                        let request = LoginRequest(username: email, password: password)
                        loginViewModel.login(request: request) { result in
                            switch result {
                            case .success(let response):
                                // Action si la connexion est réussie
                                print(response)
                                self.loginSuccess = true // Set login success to true
                                self.redirectToHomePage = true // Set redirectToHomePage to true
                            case .failure(let error):
                                // Action si la connexion échoue
                                print(error)
                            }
                        }
                    })  {
                        Text("LOGIN")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .frame(width: 170, height: 50)
                            .background(Color.white.opacity(0.6))
                            .cornerRadius(10)
                    }

                    // Redirection
                    if loginSuccess {
                        NavigationLink(destination: CardStackView(), isActive: $redirectToHomePage) {
                            EmptyView()
                        }
                    }
                    Button(action: {
                        isForgotPasswordLinkTapped = true
                    }) {
                        Text("Forgot password?")
                            .foregroundColor(.red)
                    }
                    .sheet(isPresented: $isForgotPasswordLinkTapped) {
                        ForgotPasword()
                    }


                }
                .navigationBarItems(
                    leading: Button(action: {
                        // Ajouter l'action que vous voulez exécuter lorsqu'on clique sur le bouton
                        // Dans ce cas, nous allons simplement effectuer la navigation arrière.
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                    }
                )
            }
        }
    }
    
    struct LoginPage_Previews: PreviewProvider {
        static var previews: some View {
            LoginPage()
        }
    }
}
