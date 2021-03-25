//
//  CustomViewController.swift
//  BootcampMagic
//
//  Created by rayane.x.nobrega on 18/03/21.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }

    func setupNavigation() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar
            .largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: TextColor.title]
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: TextColor.title]
        UINavigationBar.appearance()
            .titleTextAttributes = [NSAttributedString.Key.font: TextFont.title ?? .systemFont(ofSize: 36)]
    }
}
