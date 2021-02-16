//
//  AuthManager.swift
//  instasham
//
//  Created by Benjamin Tincher on 2/14/21.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    //  MARK: - Public
    
    public func registerNewUserWith(username: String, email: String, password: String) {
        
            }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
     
        if let email = email {
            
            //email login
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                
                guard authResult != nil, error == nil else {
                    return completion(false)
                }
                
                completion(true)
            }
        }
        
        if let username = username {
            
            //  username login
            print(username)
        }
    }
}
