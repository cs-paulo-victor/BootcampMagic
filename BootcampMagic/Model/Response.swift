//
//  Search.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import Foundation

struct Response: Codable {
    let cards: [Card]?
    let sets: [Expension]?

    enum CodingKeys: String, CodingKey {
        case cards, sets
    }
}
