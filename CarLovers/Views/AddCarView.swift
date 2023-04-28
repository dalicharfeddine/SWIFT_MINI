import SwiftUI
import Photos
import Combine

struct AddCarView: View {
    @ObservedObject var carViewModel = carviewModel()
        @Environment(\.presentationMode) var presentationMode
        @State var isShowingImagePicker = false
        @State var image: UIImage?
        let textLimit = 255 //Your limit
        
        var body: some View {
            
                VStack {
                    TextField("Marque!", text: $carViewModel.marque, axis: .vertical)
                        .textFieldStyle(.plain)
                        .multilineTextAlignment(.leading)
                        .frame(minHeight: 100)
                        .lineLimit(5...10)
                        .padding(5)

                    
                    TextField("Model!", text: $carViewModel.model, axis: .vertical)
                        .textFieldStyle(.plain)
                        .multilineTextAlignment(.leading)
                        .frame(minHeight: 100)
                        .lineLimit(5...10)
                        .padding(5)

                    TextField("Description!", text: $carViewModel.description, axis: .vertical)
                                      .textFieldStyle(.plain)
                                      .multilineTextAlignment(.leading)
                                      .frame(minHeight: 100)
                                      .lineLimit(5...10)
                                      .padding(5)
                                  
                    if let image = self.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    }

                    HStack {
                        Button(action: {
                            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                                DispatchQueue.main.async {
                                    switch status {
                                    case .authorized:
                                        self.isShowingImagePicker = true
                                        break
                                    case .denied, .restricted:
                                        // Handle denied or restricted permission
                                        break
                                    case .notDetermined:
                                        // Handle not determined permission
                                        break
                                    default:
                                        break
                                    }
                                }
                            }
                            // Code to be executed when the button is tapped
                            print("Button tapped")
                            self.isShowingImagePicker=true
                        }) {
                        
                                              Image(systemName: "photo").resizable().frame(width: 30,height: 30)// Set the icon using an SF Symbol
                                .foregroundColor(.gray)
                            Text("Photo").foregroundColor(Color.black)
                        } .fullScreenCover(isPresented:$isShowingImagePicker, onDismiss: nil) {
                            ImagePicker(image: $image)
                                .ignoresSafeArea()
                        }


                       
                    }
                    .frame(maxWidth:.infinity,alignment: .leading )
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                    .padding(.top, 10)

                    Button("Add Car") {
                        
                        if let selectedImage = image {
                            carViewModel.addCar(image: selectedImage) {
                                // Handle completion
                            }
                        } else {
                            // Handle case where image is nil
                        }

                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                 
                 
                .navigationBarTitle("Add Car", displayMode: .inline)
            }
        }
   

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.editedImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


struct addCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCarView()
    }
}
