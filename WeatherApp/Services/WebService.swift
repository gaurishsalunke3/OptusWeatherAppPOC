//
//  WebService.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation
import Combine

final class WebService {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
    
    func getRequest<T: Decodable>(for type: T.Type, with url: URL) -> AnyPublisher<T, Error> {
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: type.self, decoder: decoder)
            .subscribe(on: RunLoop.current)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getRequest<T: Decodable>(from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // the task has completed – push our work back to the main thread
            DispatchQueue.main.async {
                if let data = data {
                    let response = try? self.decoder.decode(T.self, from: data)
                    if let response = response {
                        print(response)
                        completion(.success(response))
                    }
                } else if error != nil {
                    // any sort of network failure
                    completion(.failure(.requestFailed(.error("Network failure."))))
                } else {
                    // this ought not to be possible, yet here we are
                    completion(.failure(.unknown(.error("Unknown Error. Please try again."))))
                }
            }
        }.resume()
    }
}
