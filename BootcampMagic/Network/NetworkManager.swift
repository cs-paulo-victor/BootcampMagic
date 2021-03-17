//
//  NetworkManager.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 17/03/21.
//

import Foundation
import UIKit

enum Result<T> {
    case success(T)
    case error(Error)
}

enum Endpoint: String {
    case cards
    case sets
}

enum Parameters: String {
    // Verificar erro ao mudar de nome 

    case set = "set"
    case type = "type"
}

enum Type: String {
    case expansion
}

public class NetworkManager {
    func request (endpoint: Endpoint, parameters: Parameters, type: Type? = nil, callback: @escaping (Result<Response>) -> Void) {
        var endpoint = "https://api.magicthegathering.io/v1/\(endpoint)?\(parameters)"

        if let type = type {
            endpoint.append("=\(type)")
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
                let response = try jsonDecoder.decode(Response.self, from: data)
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

    func requestCards (endpoint: Endpoint, parameters: Parameters, code: String, callback: @escaping (Result<Response>) -> Void) {
        let endpoint = "https://api.magicthegathering.io/v1/\(endpoint)?\(parameters)=\(code)"

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
                let response = try jsonDecoder.decode(Response.self, from: data)
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
