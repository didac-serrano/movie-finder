//
//  URLDataRetriever.swift
//  mofi
//
//  Created by Dídac Serrano i Segarra on 29/11/2021.
//

import Foundation

struct URLDataRetriever {
    
    func retrieve<T>(url: String, resultBlock: @escaping (Result<T, Error>) -> Void) where T: Decodable, T: Encodable {
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
//            print(String(data: d, encoding: String.Encoding.utf8)!)
            do {
                let json = try JSONDecoder().decode(T.self, from: d)
                resultBlock(Result.success(json))
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                resultBlock(Result.failure(DecodingError.dataCorrupted(context)))
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                resultBlock(Result.failure(DecodingError.keyNotFound(key, context)))
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                resultBlock(Result.failure(DecodingError.valueNotFound(value, context)))
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                resultBlock(Result.failure(DecodingError.typeMismatch(type, context)))
            } catch {
                print("error: ", error)
                resultBlock(Result.failure(error))
            }
        }
        task.resume()
    }
}
