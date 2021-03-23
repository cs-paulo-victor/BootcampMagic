//
//  Card.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit

struct Card: Codable {
    let name,
        idCard,
        imageUrl: String

    enum CodingKeys: String, CodingKey {
        case name
        case idCard = "multiverseid"
        case imageUrl
    }
}
