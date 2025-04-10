//
//  Login.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 08/04/25.
//

protocol LoginDataStore {
    var userEmail: String? { get set }
    var authToken: String? { get set }
}

enum Login {
    struct Login {
        struct Request {
            let email: String
            let password: String
        }
        
        struct Response {
            let success: Bool
            let error: Error?
        }
    }
}
