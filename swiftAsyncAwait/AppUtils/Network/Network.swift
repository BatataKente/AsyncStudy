//
//  Network.swift
//  swiftAsyncAwait
//
//  Created by Josicleison on 13/10/22.
//

import Foundation

struct Network {
    
    struct EndPoints {
        
        static let users = URL(string: "https://jsonplaceholder.typicode.com/users")
        static let products = URL(string: "https://fakestoreapi.com/products")
    }
    
    private enum Errors: Error {
        
        case badEndPoint
    }
    
    static func call<T: Codable>(_ what: T.Type, from url: URL?) async -> Result<T?, Error> {
        
        guard let url = url else {return .failure(Errors.badEndPoint)}
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: url)
            print(response)
            let users = try JSONDecoder().decode(what.self, from: data)
            
            return .success(users)
        }
        catch {
            
            return .failure(error)
        }
    }
}
