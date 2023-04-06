//
//  User.swift
//  CarLovers
//
//  Created by DaliCharf on 31/3/2023.
//

import Foundation

/*struct SignupResponse: Decodable {
    let _id: String?
    let username: String?
    let email: String?
    let role: String?
    let datedenaissance: String?
    let numero: String?
    let password: String?
    let __v: Int=0
}
*/
struct SignupRequest: Encodable {
    let username: String
    let email: String
    let datedenaissance: String
    let numero: String
    let role: String="user"
    let password: String
}

struct SignupResponse: Decodable {
    let status: String
    let message: String
}
struct ErrorResponse: Decodable {
    let message: String
}

struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct LoginResponse: Decodable {
    let message: String
    let accessToken: String
    let user: User
}


struct User: Decodable {
    let _id: String
    let username: String
    let email: String
    let role: String
    let datedenaissance: String
    let numero: Int
    let password: String
    let __v: Int
}

struct UpdateUserRequest: Encodable {
    let username: String?
    let email: String?
    let datedenaissance: String?
    let numero: String?
}
