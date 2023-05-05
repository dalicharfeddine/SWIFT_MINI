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
    let adresse: String
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


class User: Decodable, Identifiable {
    let _id: String
    let username: String
    let email: String
    let role: String
    let datedenaissance: String
    let numero: Int
    let adresse: String
    let password: String
    let __v: Int
    
}


struct UpdateUserRequest: Encodable {
    let username: String?
    let email: String?
    let datedenaissance: String?
    let adresse: String
    let numero: String?
}



struct SendMailRequest: Encodable {
    let email: String
}

struct VerifyCodeRequest: Encodable {
    let email: String
    let codeForget: String
}
struct ResetPasswordRequest: Encodable {
    let email: String
    let codeForget: String
    let password: String
}
struct ChangePasswordRequest: Encodable {
    let id: String
    let username: String
    let email: String
    let password: String
}
