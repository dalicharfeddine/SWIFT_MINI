import SwiftUI

struct UpdateProfile: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var phoneNumber: String = ""
    @ObservedObject var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        let userDefaults = UserDefaults.standard
        let username = userDefaults.string(forKey: "username") ?? ""
        let email = userDefaults.string(forKey: "email") ?? ""
        let dateOfBirth = userDefaults.object(forKey: "dateOfBirth") as? Date ?? Date()
        let phoneNumber = userDefaults.string(forKey: "phoneNumber") ?? ""

        _username = State(initialValue: username)
        _email = State(initialValue: email)
        _dateOfBirth = State(initialValue: dateOfBirth)
        _phoneNumber = State(initialValue: phoneNumber)
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
                        }

                        Section {
                            Button("Save Changes") {
                                let request = UpdateUserRequest(username: username, email: email, datedenaissance: formatDate(dateOfBirth), numero: phoneNumber)
                                viewModel.updateUser(request: request) {
                                    // handle completion, e.g.:
                                    print("User updated successfully!")
                                }
                            }
                        }
                    }
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
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
}

struct UpdateProfile_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfile(viewModel: ProfileViewModel())
    }
}
