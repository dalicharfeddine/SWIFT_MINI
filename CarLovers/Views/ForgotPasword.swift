import SwiftUI

struct ForgotPasword: View {
    @State private var email = ""
    @State private var redirectToConfirmation = false
    @State var isPresenting = false

    @StateObject var forgetPasswordViewModel = ForgetPasswordModel()

    var body: some View {
        NavigationView{
            ZStack {
                Image("bmw")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("logocarknights")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                    Section{
                        Text("Enter your email address and we will send you a link to reset your password.")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    
                    TextField("Email", text: $forgetPasswordViewModel.email)
                        .onChange(of: forgetPasswordViewModel.email) { value in
                            forgetPasswordViewModel.validateEmail()
                        } .padding()
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.system(size: 16, weight: .medium))
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.horizontal, 30)
                    
                    if let errorMessage = forgetPasswordViewModel.emailError {
                        Text(errorMessage)
                            .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
                    }
                    
                    
                    Button(action: {
                        
                        print(forgetPasswordViewModel.email)
                        let request = SendMailRequest(email: forgetPasswordViewModel.email)
                        forgetPasswordViewModel.sendEmail(request: request) { result in
                            switch result {
                            case .success(let response):
                                if(response == "Email not found"){
                                    isPresenting = false
                                }
                                else if(response == "Verification code sent sucessfully"){
                                    
                                    isPresenting = true
                                }
                                else{
                                    isPresenting = false
                                }
                                // Action si la connexion est réussie
                                print(response)
                                
                                //   self.redirectToHomePage = true // Set redirectToHomePage to true
                            case .failure(let error):
                                // Action si la connexion échoue
                                print(error)
                            }
                        }
                    }) {
                        Text("Send")
                            .padding()
                            .foregroundColor(Color.white)
                        
                        
                        
                    }    .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(10)
                        .padding(.top,20)
                    
                        .foregroundColor(Color.gray)
                    
                    NavigationLink(destination: VerificationOtpScreen(email: $forgetPasswordViewModel.email).navigationBarBackButtonHidden(true), isActive: $isPresenting) { EmptyView() }
                    
                    HStack{
                        
                        Text("Back to ?").foregroundColor(Color.gray)
                        NavigationLink(destination: LoginPage()) {
                            Text("Login").foregroundColor(Color.red)
                            
                        }}
                }.padding(20)
            }
        }}
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasword()
    }
}
