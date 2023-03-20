//
//  SignInPage.swift
//  CarKnights
//
//  Created by DaliCharf on 20/3/2023.
//

import SwiftUI

struct SignInPage: View {
    @State private var fullName = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var password = ""
    @State private var birthDate = Date()
    @State private var showDatePicker = false

    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        NavigationView{
            
            ZStack{
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
                        Button(action: {
                            self.showDatePicker.toggle()
                        }) {
                            Text("Date of Birth")
                                .padding(.horizontal, 20) // Adjust horizontal padding
                                .padding(.vertical, 8) // Adjust vertical padding
                                .background(Color.gray.opacity(0.9))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium))
                                .textContentType(.name)
                        }
                        .padding(.bottom, 8) // Add padding below button

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
                            .textContentType(.name)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)



                    
                    Button(action: {
                        // Action when sign in button is tapped
                    }, label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    })
                    .padding(.bottom,30)
                }
                .padding(.all,40)
                
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

struct SignInPage__Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
    }
}
