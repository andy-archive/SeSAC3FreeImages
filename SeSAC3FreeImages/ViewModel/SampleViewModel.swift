//
//  SampleViewModel.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/12.
//

import UIKit

class SampleViewModel {
    
    var list = [
        User(name: "Hue", age: 23),
        User(name: "Jack", age: 21),
        User(name: "Bran", age: 20),
        User(name: "Kokojong", age: 20),
    ]
    
    var numberOfRowsInSection: Int {
        return list.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> User {
        return list[indexPath.row]
    }
}
