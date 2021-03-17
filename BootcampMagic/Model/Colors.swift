//
//  Colors.swift
//  BootcampMagic
//
//  Created by rayane.x.nobrega on 17/03/21.
//

import UIKit

private enum Colors {
    static let black = UIColor.black
    static let white = UIColor.white
}

enum TextColor {
    static let title = Colors.white
    static let subtitle = Colors.black
    static let body = Colors.white
    static let nameCard = Colors.white
    static let button = Colors.white

}

enum BackgroundColor {
    static let navigation = Colors.white.withAlphaComponent(0.0)
    static let subtitle = Colors.white
    static let overlay = Colors.white.withAlphaComponent(0.0)
    static let nameCard = Colors.white.withAlphaComponent(0.0)
}
