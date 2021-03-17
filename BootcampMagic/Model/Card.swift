//
//  Card.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit

struct Card: Codable {
    let imageUrl,
        idCard,
        name: String

    enum CodingKeys: String, CodingKey {
        case imageUrl = "imageUrl"
        case idCard = "id"
        case name = "name"
    }
}
