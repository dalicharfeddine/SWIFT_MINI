//
//  ContactViewModel.swift
//  CarLovers
//
//  Created by DaliCharf on 2/5/2023.
//

import Foundation

import Alamofire

class ListEventViewModel: ObservableObject {
    @Published var contacts: [eventResponse] = []

    func fetchEvents(userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")",
            "Content-Type": "application/json"
        ]
        let url = "http://172.17.1.173:9091/event"

        AF.request(url, headers: headers)
            .validate()
            .responseJSON { [weak self] response in
                switch response.result {
                case .success(let data):
                    print("Response data:", data)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let contacts = try decoder.decode([eventResponse].self, from: jsonData)
                        DispatchQueue.main.async {
                            self?.contacts = contacts
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
