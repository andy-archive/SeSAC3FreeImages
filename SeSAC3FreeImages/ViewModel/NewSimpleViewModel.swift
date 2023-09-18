//
//  NewSimpleViewModel.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/18.
//

import Foundation

class NewSimpleViewModel {
    var list: Observable<[User]> = Observable( [ ] )
    
    let list2 = [
        User(name: "Hue", age: 23),
        User(name: "Jack", age: 23),
        User(name: "Bran", age: 20),
        User(name: "Kokojong", age: 20),
    ]
    
    func append() {
        list.value = [
            User(name: "Andy", age: 25),
            User(name: "Roen", age: 27),
            User(name: "Joey", age: 21),
            User(name: "Eddy", age: 23),
        ]
    }
    
    func remove() {
        list.value = []
    }
    
    func removeUser(index: Int) {
        list.value.remove(at: index)
    }
    
    func insertUser(name: String) {
        let value = User(name: name, age: Int.random(in: 20..<70))
        list.value.insert(value, at: Int.random(in: 0...2))
    }
}
