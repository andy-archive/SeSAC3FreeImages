//
//  CustomObservable.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/13.
//

import Foundation

class CustomObservable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ completion: @escaping (T) -> Void) {
        completion(value)
        listener = completion
    }
}
