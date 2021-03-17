//
//  Typography.swift
//  BootcampMagic
//
//  Created by rayane.x.nobrega on 17/03/21.
//

import UIKit

private enum Fonts {
    static let big = UIFont(name: "Roboto-bold", size: 36)
    static let middle = UIFont(name: "Roboto-bold", size: 30)
    static let small = UIFont(name: "Roboto-bold", size: 18)
    static let tiny = UIFont(name: "Roboto-bold", size: 16)
}

enum TextFont {
    static let title = Fonts.big
    static let subtitle = Fonts.small
    static let body = Fonts.small
    static let nameCard = Fonts.middle
    static let detail = Fonts.tiny
    static let button = Fonts.tiny
}

enum TextAlignment {
    static let left = NSTextAlignment.left
    static let nameCard = NSTextAlignment.center
}
