//
//  Contact.swift
//  CarLovers
//
//  Created by DaliCharf on 2/5/2023.
//

import Foundation


struct
Contact: Decodable,Hashable {
    let _id: String
    let user1: userContact
    let user2: userContact
    let match: Bool
    let __v: Int

}
struct userContact: Decodable,Hashable {
    let _id: String
    let username: String
    let email: String
    let numero: Int
}
