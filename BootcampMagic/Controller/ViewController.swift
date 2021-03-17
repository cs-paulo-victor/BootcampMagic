//
//  ViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager().request(endpoint: .sets, type: .expansion) { (result) in
            switch result {
            case .success(let data):
                guard let resultado = data.sets else { return }
                print((resultado.map({ $0.name })).sorted())
            case .error(let anError):
                print("Error: \(anError)")
            }
        }

    }
}
