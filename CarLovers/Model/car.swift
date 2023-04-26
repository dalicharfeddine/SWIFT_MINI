//
//  car.swift
//  CarLovers
//
//  Created by DaliCharf on 14/4/2023.
//

import Foundation


struct AddcarRequest: Encodable {
    let marque: String
    let model: String
    let description: String
    let imager: String
    let user: String
}
struct AddcarResponse: Decodable {
    let status: String
    let message: String
}


struct carResponse: Codable {
    let _id: String
    let marque: String
    let model: String
    let image: String
    let user: String
    let description: String
    let __v: Int

}




