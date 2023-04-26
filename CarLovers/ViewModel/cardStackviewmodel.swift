//
//  cardStackviewmodel.swift
//  CarLovers
//
//  Created by DaliCharf on 19/4/2023.
//
import Foundation
import Alamofire

class cardStackviewmodel: ObservableObject {
    @Published var cars: [carResponse] = []
    
    func getCars() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")",
        ]
        
        AF.request("http://192.168.100.105:9091/car", headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.cars = try decoder.decode([carResponse].self, from: data)
                    for car in self.cars {
                        print(car.marque)
                    }

                } catch {
                    print("Failed to decode car response: \(error)")
                }
            case .failure(let error):
                print("Error fetching cars: \(error)")
            }
        }
    }
    
    func getContact() {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Error: Access token not found")
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "user": "user1"
        ]

      
        AF.request("http://192.168.100.105:9091/contact/user2", method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success:
                print("Request succeeded")
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }



}
