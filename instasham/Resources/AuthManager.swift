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
    
    public func registerNewUserWith(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        //   check if username is available, check if email is available, create account, insert account to database
        DatabaseManager.shared.canCreateNewUserWith(email: email, username: username) { (canCreate) in
            
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    
                    guard error == nil, authResult != nil else { return completion(false) }
                    //  Insert into database
                    DatabaseManager.shared.insertNewUserWith(email: email, username: username) { (inserted) in
                        if inserted {
                            return completion(true)
                        } else {
                            //  Failed to insert to Database
                            return completion(false)
                        }
                    }
                }
            } else {
                // either username or email does not exist
                completion(false)
            }
        }
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
