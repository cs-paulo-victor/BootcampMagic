//
//  Set.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 17/03/21.
//

import Foundation

struct CardSet: Codable {
    let code,
        name,
        type: String

    enum CodingKeys: String, CodingKey {
        case code, name, type
    }
}
