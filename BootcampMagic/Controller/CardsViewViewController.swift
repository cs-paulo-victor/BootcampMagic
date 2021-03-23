//
//  CardsViewViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 23/03/21.
//

import UIKit

class CardsViewViewController: CustomViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = CardsListView()
    }

}
