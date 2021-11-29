//
//  URLDataRetriever.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 29/11/2021.
//

import Foundation

struct URLDataRetriever {
    
    func retrieve<T>(url: String, resultBlock: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        guard let url = URL(string: url) else {
            assertionFailure("wrong url format")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let e = error {
                resultBlock(Result.failure(e))
            }
            if let r = response as? HTTPURLResponse {
                print(r.statusCode)
            }
            guard let d = data else { return }
            do {
                let json = try JSONDecoder().decode(T.self, from: d)
                resultBlock(Result.success(json))
            } catch let error {
                resultBlock(Result.failure(error))
            }
        }
        task.resume()
    }
}
