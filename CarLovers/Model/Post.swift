//
//  Post.swift
//  CarLovers
//
//  Created by Mohamed amine Regaia on 27/4/2023.
//

import Foundation



struct Post: Encodable {
    let titre: String
    let description: String
    let imagePost: String
    let user: String

}
struct AddPostResponse: Decodable {
    let status: String
    let message: String
}



struct Postaffichage: Decodable,Hashable {
    let _id: String
    let titre: String
    let description: String
    let imagePost: String
    let user: userPost
    let __v: Int


}

struct userPost: Decodable,Hashable {
    let _id: String
    let username: String

}
