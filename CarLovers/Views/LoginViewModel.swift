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
    let accessTokenKey = "accessToken"
    let userIdKey = "userId"

    
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> ()) -> DataRequest {
        let url = "http://172.17.2.212:9091/user/login"
        
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
                                
                                UserDefaults.standard.set(loginResponse.accessToken, forKey: self.accessTokenKey)
                                UserDefaults.standard.set(loginResponse.user._id, forKey: self.userIdKey)
                                completion(.success(loginResponse))
                                print(UserDefaults.standard.dictionaryRepresentation())

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
