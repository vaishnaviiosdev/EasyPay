//
//  Model.swift
//  EasyPay
//
//  Created by Vaishnavi on 12/12/24.
//

import Foundation

struct User: Decodable {
    let id: Int
    let login: String
    let avatar_url: String
}
