//
//  Card.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit

struct Card: Codable {
    let name: String
    let imageUrl: String?
    let types: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case types
        case imageUrl
    }
}
