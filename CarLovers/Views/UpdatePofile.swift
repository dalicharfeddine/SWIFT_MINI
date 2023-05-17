import SwiftUI

struct UpdateProfile: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var adresse: String = ""
    @State private var phoneNumber: String = ""
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode


    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        let userDefaults = UserDefaults.standard
        let username = userDefaults.string(forKey: "username") ?? ""
        let email = userDefaults.string(forKey: "email") ?? ""
        let dateOfBirth = userDefaults.object(forKey: "dateOfBirth") as? Date ?? Date()
        let phoneNumber = userDefaults.string(forKey: "phoneNumber") ?? ""
        let adresse = userDefaults.string(forKey: "adresse") ?? ""

        _username = State(initialValue: username)
        _email = State(initialValue: email)
        _dateOfBirth = State(initialValue: dateOfBirth)
        _phoneNumber = State(initialValue: phoneNumber)
        _adresse = State(initialValue: adresse)

    }

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack {
                    Form {
                        Section(header: Text("Personal Information")) {
                            TextField("Username", text: $username)
                            TextField("Email", text: $email)
                            DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                            TextField("Phone Number", text: $phoneNumber)
                            TextField("Adresse", text: $adresse)
                        }

                        Section {
                            Button("Save Changes") {
                                let request = UpdateUserRequest(username: username, email: email, datedenaissance: formatDate(dateOfBirth), adresse: adresse, numero: phoneNumber)
                                viewModel.updateUser(request: request) {
                                    // handle completion, e.g.:
                                    print("User updated successfully!")
                                }
                            }
                        }
                    }
                    Button(action: {
                                         logout()
                                     }, label: {
                                         Text("Logout")
                                             .foregroundColor(.white)
                                             .font(.headline)
                                     })
                                     .frame(maxWidth: .infinity)
                                     .frame(height: 50)
                                     .background(Color.red)
                                     .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .navigationTitle("Edit Profile")
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    private func logout() {
        // Remove the saved user information
        UserDefaults.standard.removeObject(forKey: "accessToken")

        // Present the login view wrapped in a NavigationView
        let loginView = LoginPage()
        let loginViewWithNavigation = NavigationView { loginView }
        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: loginViewWithNavigation)

        // Dismiss the current view
        dismiss()
    }

    private func dismiss() {
        // Dismiss the view
        presentationMode.wrappedValue.dismiss()
    }
}

struct UpdateProfile_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfile(viewModel: ProfileViewModel())
    }
}
