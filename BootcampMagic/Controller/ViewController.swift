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

        NetworkManager().request(endpoint: .sets, parameters: .type, type: .expansion) { (result) in
            switch result {
            case .success(let data):
                guard let resultado = data.sets else { return }
                print((resultado.map({ $0.name })).sorted())
                print(resultado.map({ $0.code }))
            case .error(let anError):
                print("Error: \(anError)")
            }
        }

        NetworkManager().requestCards(endpoint: .cards, parameters: .set, code: "5DN", callback: { (result) in
            switch result {
            case .success(let data):

                guard let resultado = data.cards else { return }
                print(resultado.map { $0.name })
                print(resultado.map { $0.idCard })
                print(resultado.map { $0.imageUrl })

            case .error(let anError):
                print("Error: \(anError)")
            }
        })
    }
}
