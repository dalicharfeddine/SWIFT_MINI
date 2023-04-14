//
//  LoginViewModel.swift
//  CarLovers
//
//  Created by DaliCharf on 31/3/2023.
//

import Alamofire

class LoginViewModel: ObservableObject {
    
    var loginRequest: LoginRequest?
    var errorMessage: String?
    
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> ()) -> DataRequest {
        let url = "http://192.168.100.105:9091/user/login"
        
        do {
            let encodedRequest = try JSONEncoder().encode(request)
            var urlRequest = try URLRequest(url: url, method: .post)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = encodedRequest
            
            return AF.request(urlRequest)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                        case .success(let data):
                            do {
                                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                                let user = loginResponse.user // Utilisez cette ligne pour récupérer toutes les informations sur l'utilisateur
                                
                                // Save access token to UserDefaults
                                UserDefaults.standard.set(loginResponse.accessToken, forKey: userDefaultsKey)
                                
                                completion(.success(loginResponse))
                            } catch {
                                print(error)
                                completion(.failure(error))
                            }
                        case .failure(let error):
                            print(error)
                            completion(.failure(error))
                    }
                }
        } catch {
            print(error)
            completion(.failure(error))
        }
        // default return statement
        return AF.request(url)
    }
}
