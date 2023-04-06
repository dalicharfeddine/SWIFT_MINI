//
//  ProfileViewModel.swift
//  CarLovers
//
//  Created by DaliCharf on 6/4/2023.
//

import Alamofire

let userDefaultsKey = "accessToken"


class ProfileViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var errorMessage: String = ""
    
    func fetchUser() {
        let url = "http://192.168.100.105:9091/user/profile"
        
        guard let accessToken = UserDefaults.standard.string(forKey: userDefaultsKey) else {
            self.errorMessage = "Access Token not found"
            return
        }
        
        let headers: HTTPHeaders = [            "Authorization": "Bearer \(accessToken)",            "Content-Type": "application/json"        ]
        
        AF.request(url, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
    }
    
    func updateUser(request: UpdateUserRequest, completion: @escaping () -> Void) {
        let url = "http://192.168.100.105:9091/user/profile"
        
        guard let accessToken = UserDefaults.standard.string(forKey: userDefaultsKey) else {
            self.errorMessage = "Access Token not found"
            return
        }
        
        let headers: HTTPHeaders = [            "Authorization": "Bearer \(accessToken)",            "Content-Type": "application/json"        ]
        
        AF.request(url, method: .put, parameters: request, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success(_):
                    completion()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
    }
}
