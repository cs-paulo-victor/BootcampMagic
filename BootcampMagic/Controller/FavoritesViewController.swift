//
//  FavoritosViewController.swift
//  BootcampMagic
//
//  Created by rayane.x.nobrega on 18/03/21.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = TextColor.title
    }

}
