//
//  EndPoints.swift
//  swiftAsyncAwait
//
//  Created by Josicleison on 17/10/22.
//

import Foundation

struct EndPoints {
    
    static let users = URL(string: "https://jsonplaceholder.typicode.com/users")
    
    static let user = {(id: Int) -> URL? in
        
        return URL(string: "https://jsonplaceholder.typicode.com/users/\(id)")
    }
    
    static let products = URL(string: "https://fakestoreapi.com/products")
    
    static let product = {(_ id: Int) -> URL? in
        
        return URL(string: "https://fakestoreapi.com/products/\(id)")
    }
}
