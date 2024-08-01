//
//  FirabaseImageStorage.swift
//  FirebaseDeneme
//
//  Created by Yunus Emre ÖZŞAHİN on 27.07.2024.
//
import FirebaseStorage
import UIKit

class FirebaseImageStorage {
    func uploadProfileImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "ImageConversionError", code: 0, userInfo: nil)))
            return
        }

        let storageRef = Storage.storage().reference().child("profile_images").child(UUID().uuidString)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let downloadURL = url?.absoluteString else {
                    completion(.failure(NSError(domain: "URLFetchError", code: 0, userInfo: nil)))
                    return
                }
                
                completion(.success(downloadURL))
            }
        }
    }
    
    func downloadProfileImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let storageRef = Storage.storage().reference(forURL: url)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(NSError(domain: "ImageDownloadError", code: 0, userInfo: nil)))
            }
        }
    }
}
