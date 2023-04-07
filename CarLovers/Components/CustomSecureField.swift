//
//  CustomSecureField.swift
//  CarLovers
//
//  Created by DaliCharf on 7/4/2023.
//

import Foundation
import SwiftUI

struct PasswordView: View {
    
    var leftIcon : String

    var placeHolder : String

    
    @State private var isEditing = false
    @State private var edges = EdgeInsets(top: 0, leading:45, bottom: 0, trailing: 0)
    
    
    private enum Field : Int, Hashable {
        case fieldName
    }
    
    @Binding var password: String
    @State private var secured = true
    
    @FocusState private var focusField : Field?
    var body: some View {
        ZStack(alignment : .leading) {
            HStack{
                
                Image(systemName: leftIcon)
                    .foregroundColor(Color.secondary)
                if secured{
                    SecureField(placeHolder,text:$password)
                        .padding()
                        .background(Color.gray.opacity(0.9))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.system(size: 16, weight: .medium))
                        .textContentType(.name)
                    
            
                    }

            
                else{
                    TextField(placeHolder, text: $password) { status in
                        
                    }
                    .padding()
                                        .background(Color.gray.opacity(0.9))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .accentColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                        .textContentType(.name)
                    
                }
                Button {
                    secured.toggle()
                } label: {
                    Image(systemName: secured ? "eye.slash" : "eye")
                }
                .buttonStyle(BorderlessButtonStyle())
            }.padding()
 
        }
    } }
