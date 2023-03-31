//
//  CarsView.swift
//  CarLovers
//
//  Created by DaliCharf on 21/3/2023.
//

import SwiftUI

struct CarsView: View {
    @State private var selectedImage: UIImage?
    @State private var marque: String = ""
    @State private var model: String = ""
    @State private var description: String = ""
    
    var body: some View {
        VStack {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding()
            } else {
                Button(action: {
                    // TODO: Implement image picker
                }) {
                    Text("Upload Image")
                }
                .buttonStyle(UploadButtonStyle())
            }
            
            Form {
                Section(header: Text("Car Information")) {
                    TextField("Brand", text: $marque)
                    TextField("Model", text: $model)
                    TextEditor(text: $description)
                }
                
                Section {
                    Button(action: {
                        // TODO: Implement save action
                    }) {
                        Text("Save")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
        .navigationBarTitle("Add Car")
    }
}

struct UploadButtonStyles: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(Color.white)
            .background(configuration.isPressed ? Color.gray : Color.blue)
            .cornerRadius(8)
    }
}

struct Car_Preview: PreviewProvider {
    static var previews: some View {
        CarsView()
    }
}
