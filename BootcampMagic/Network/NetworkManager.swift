//
//  NetworkManager.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 17/03/21.
//

import Foundation
enum Result<T> {
    case success(T)
    case error(Error)
}

enum Endpoint: String {
    case cards
    case sets
}

enum Type: String {
    case expansion
}

public class NetworkManager {
    func searchCards (endpoint: Endpoint, type: Type? = nil, callback: @escaping (Result<Search>) -> Void) {
        var endpoint = "https://api.magicthegathering.io/v1/\(endpoint)"
        if let type = type {
            endpoint.append("?type=\(type)")
        }
        guard let url = URL(string: endpoint) else {
            callback(.error(NSError()))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }

            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode(Search.self, from: data)
                DispatchQueue.main.async {
                    callback(.success(response))
                }
            } catch {
                DispatchQueue.main.async {
                    callback(.error(error))
                }
            }
        }
    task.resume()
    }
}
