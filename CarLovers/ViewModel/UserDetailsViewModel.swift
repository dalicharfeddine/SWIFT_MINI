//
//  UserDetailsViewModel.swift
//  CarLovers
//
//  Created by DaliCharf on 2/5/2023.
//
import Alamofire
import Foundation

class UserDetailsViewModel: ObservableObject {
    @Published var user: userContact?

    func fetchUserDetails(username: String, completion: @escaping (Result<Void, Error>) -> Void) {
       
        let url = "http://172.17.2.212:9091/user/\(username)"
        AF.request(url)
            .validate()
            .responseJSON { [weak self] response in
                switch response.result {
                case .success(let data):
                    print("Response data:", data)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let user = try decoder.decode(userContact.self, from: jsonData)
                        DispatchQueue.main.async {
                            self?.user = user
                            completion(.success(()))
                        }
                    } catch {
                        print("Error decoding response:", error)
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Request failed with error:", error)
                    completion(.failure(error))
                }
            }
    }
}
