//
//  SignInPage.swift
//  CarKnights
//
//  Created by DaliCharf on 20/3/2023.
//
import Alamofire
import SwiftUI

        struct SignInPage: View {
            @State private var isPresented = false

        @State private var fullName = ""
        @State private var phoneNumber = ""
        @State private var email = ""
        @State private var password = ""
        @State private var birthDate = Date()
        @State private var showDatePicker = false
            
        
            var dateFormatter: DateFormatter {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                return formatter
            }



        @ObservedObject var viewModel = SignupViewModel()


        @Environment(\.presentationMode) var presentationMode

        var body: some View {
            NavigationView {
                ZStack {
                    Image("bmw")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 5) {
                        Image("logocarknights")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                        
                        Text("Create an Account")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        HStack {
                            TextField("Full Name", text: $fullName)
                             .padding()
                             .background(Color.gray.opacity(0.9))
                             .cornerRadius(10)
                            .foregroundColor(.white)
                             .font(.system(size: 16, weight: .medium))
                             .textContentType(.name)
                          .foregroundColor(Color.white)
                            
                            TextField("Phone Number", text: $phoneNumber)
                            .padding()
                            .background(Color.gray.opacity(0.9))
                            .cornerRadius(10)
                           .foregroundColor(.white)
                           .font(.system(size: 16, weight: .medium))
                           .textContentType(.name)
                           .foregroundColor(Color.white)
                        }
                        
                        TextField("Email", text: $email)
                            .padding()
                             .background(Color.gray.opacity(0.9))
                             .cornerRadius(10)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .font(.system(size: 16, weight: .medium))
                            .textContentType(.name)
                        
                        SecureField("Password", text: $password)
                            .padding()
                              .background(Color.gray.opacity(0.9))
                               .cornerRadius(10)
                               .foregroundColor(.white)
                              .accentColor(.white)
                               .font(.system(size: 16, weight: .medium))
                            .textContentType(.name)
                        
                    
                        VStack {
                            HStack {
                                Button(action: {
                                    self.showDatePicker.toggle()
                                }) {
                                    Text("Date of Birth")
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)
                                        .background(Color.gray.opacity(0.9))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                }
                                .padding(.bottom, 8)
                                Spacer()
                                Text(dateFormatter.string(from: birthDate))
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color.gray)
                            }
                            
                            if showDatePicker {
                                DatePicker(
                                    "",
                                    selection: $birthDate,
                                    displayedComponents: [.date]
                                )
                                .datePickerStyle(WheelDatePickerStyle())
                                .padding()
                                .background(Color.gray.opacity(0.9))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .accentColor(.white)
                                .font(.system(size: 16, weight: .medium))
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        
                        Button(action: {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let birthDateString = dateFormatter.string(from: birthDate)
                            let request = SignupRequest(username: fullName, email: email, datedenaissance: birthDateString, numero: phoneNumber, password: password)
                            
                            viewModel.signup(request: request) { result in
                                switch result {
                                case .success(let response):
                                    // Handle successful sign up
                                    print(response)
                                    // Dismiss the sign in view after successful sign up
                                    presentationMode.wrappedValue.dismiss()
                                    
                                    // Redirect to login page
                                    presentationMode.wrappedValue.dismiss() // dismiss the current view
                                    isPresented = false // set isPresented to false to dismiss the sheet
                                    
                                case .failure(let error):
                                    // Handle error
                                    print(error.localizedDescription)
                                }
                            }
                        }) {
                            Text("Sign Up")
                                .font(.headline)
                                                               .foregroundColor(.white)
                                                               .padding()
                                                               .frame(maxWidth: .infinity)
                                                               .background(Color.gray.opacity(0.3))
                                                               .cornerRadius(10)
                        }

                        // use NavigationLink to redirect to LoginPage if sign up is successful

                        NavigationLink(destination: LoginPage(), isActive: $isPresented) {
                            EmptyView()
                        }

                    }
                }
            }
        }
        }

struct SignInPage_Previews: PreviewProvider {
            static var previews: some View {
        SignInPage()
        }
        }
