//
//  NetworkManageFake.swift
//  BootcampMagicTests
//
//  Created by rayane.x.nobrega on 25/03/21.
//

import XCTest
@testable import BootcampMagic

class NetworkManageFake: NetworkManager {
    var requestCalled = false

    override func requestCards(
        endpoint: Endpoint,
        parameters: Parameters,
        code: String,
        callback: @escaping (Result<Response>) -> Void) {
        let response = Response(cards: [], sets: [])
        requestCalled = true
        callback(.success(response))
    }
}
