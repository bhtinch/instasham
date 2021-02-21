//
//  StorageManager.swift
//  instasham
//
//  Created by Benjamin Tincher on 2/14/21.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    //  MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImageWith(reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void ) {
        bucket.child(reference).downloadURL { (url, error) in
            guard let url = url, error == nil else {
                return completion(.failure(.failedToDownload))
            }
            completion(.success(url))
        }
    }
}

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}
