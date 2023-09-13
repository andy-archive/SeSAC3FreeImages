//
//  APIService.swift
//  SeSAC3FreeImages
//
//  Created by Taekwon Lee on 2023/09/12.
//

import UIKit
 
class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    private let headers = [
        "Authorization": "Client-ID \(APIKey.unsplashAccess)"
    ]
    
    func searchPhoto(query: String, completion: @escaping (Photo?) -> Void) {
    
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)") else { return }
//        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(APIKey.unsplashAccess)") else { return }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Photo.self, from: data!)
                completion(result)
                
            } catch {
                print(error)
            }
        }
        
        dataTask.resume()
    }
    
    func loadImage(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            
            var image: UIImage?
            
            defer {
                DispatchQueue.main.async {
                    completionHandler(image)
                }
            }
            
            if let data = data {
                image = UIImage(data: data)
            }
            
        }
        dataTask.resume()
    }
    
}
