//
//  Api.swift
//  CarLovers
//
//  Created by DaliCharf on 20/3/2023.
//

import Alamofire


class MyService {
    
    
    class Item: Decodable {
        var id: Int
        var name: String
        // Ajoutez d'autres propriétés ici si nécessaire

        // Définissez vos propres clés de codage si les noms de propriétés ne correspondent pas à ceux du JSON
        private enum CodingKeys: String, CodingKey {
            case id
            case name
        }
    }

    func fetchItems(completion: @escaping ([Item]?) -> Void) {
        AF.request("https://carknights.onrender.com").responseDecodable(of: [Item].self) { (response: DataResponse<[Item], AFError>) in
            // Handle response here
            guard let data = response.data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let items = try decoder.decode([Item].self, from: data)
                completion(items)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }

}

