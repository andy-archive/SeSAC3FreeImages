//
//  User.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/12.
//

import Foundation

class User: Hashable {

    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // id 기준 고유성 판별 -> 같은지 아닌지 판별
    }


    let name: String
    let age: Int

    let id = UUID().uuidString

    var introduce: String {
        return "\(name), \(age)살"
    }

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


