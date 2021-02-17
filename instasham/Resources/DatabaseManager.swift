//
//  DatabaseManager.swift
//  instasham
//
//  Created by Benjamin Tincher on 2/14/21.
//
import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //  MARK: - Public
    
    ///  check if user and email is available
    /// - Parameters
    ///     - email: String representing email
    ///      - username: String representing username
    public func canCreateNewUserWith(email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    ///  inserts new user data into database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeeded
    public func insertNewUserWith(email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { (error, _) in
            if error == nil {
                //  succeeded
                return completion(true)
            } else {
                //  failed
                return completion(false)
            }
        }
    }
        
}
