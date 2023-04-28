////
//  LoginPage.swift
//  CarKnights
//
//  Created by DaliCharf on 20/3/2023.
//

import SwiftUI
import LocalAuthentication
struct LoginPage: View {
    @StateObject var loginViewModel = LoginViewModel()
    
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var loginSuccess = false
    @State var redirectToHomePage = false
    @State private var isForgotPasswordLinkTapped = false
    @State private var isUnlocked = false

        @State private var showHomePageView = false


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
                    
                    VStack {
                                        if isUnlocked {
                                            NavigationLink("", destination: HomePage().navigationBarHidden(true), isActive: $showHomePageView)
                                        } else {
                                            Image(systemName: "faceid")
                                                 .resizable()
                                                 .frame(width: 50, height: 50)
                                                 .foregroundColor(.white)
                                                 .onTapGesture {
                                                     authenticateWithBiometrics()
                                                 }
                                        }
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
                        NavigationLink(destination: HomePage().navigationBarHidden(true), isActive: $redirectToHomePage)
                           {
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
                    //hedhi button
                    


                }
             
            }
        }
    }
    private func authenticateWithBiometrics() {
            let context = LAContext()
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                print("canEvaluatePolicy returned true")
                let reason = "Log in with Face ID"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                    if success {
                        print("Authentication successful")
                        DispatchQueue.main.async {
                            isUnlocked = true
                            showHomePageView = true
                        }
                    } else {
                        print("Authentication failed: \(error?.localizedDescription ?? "unknown error")")
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Authentication Failed", message: error?.localizedDescription ?? "Please try again", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(okAction)
                        }
                    }
                }
            } else {
                print("canEvaluatePolicy returned false: \(error?.localizedDescription ?? "unknown error")")
                let alertController = UIAlertController(title: "Face ID Not Available", message: error?.localizedDescription ?? "Your device does not support Face ID", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                // Same as above
            }
        }
    
    struct LoginPage_Previews: PreviewProvider {
        static var previews: some View {
            LoginPage()
        }
    }
}
