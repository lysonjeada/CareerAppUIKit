//
//  Login.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 08/04/25.
//

protocol LoginDataStore {
    // Pode adicionar propriedades se necessário
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
        
        struct ViewModel {
            let success: Bool
            let errorMessage: String?
        }
    }
}
