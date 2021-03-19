//
//  Set.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 17/03/21.
//

import Foundation

public struct CardSet: Codable {
    let code,
        name,
        type: String

    enum CodingKeys: String, CodingKey {
        case code
        case name
        case type

    }
}
