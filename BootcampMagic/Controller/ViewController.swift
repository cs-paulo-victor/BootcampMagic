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
        fetchExpansions()
    }
}

extension ViewController {
    func fetchExpansions() {
        NetworkManager().requestExpansions(endpoint: .sets, parameters: .type, type: .expansion) { (result) in
            switch result {
            case .success(let data):
                guard let resultado = data.sets else { return }
                let expansion = resultado.sorted { $0.name < $1.name }
//                print(self.expansion.map({ $0.name }))
//                print(self.expansion.map({ $0.code }))
            case .error(let anError):
                print("Error: \(anError)")
            }
        }
    }

    func fetchCards(codeCard: String) {
        NetworkManager().requestCards(endpoint: .cards, parameters: .set, code: codeCard, callback: { (result) in
            switch result {
            case .success(let data):
                guard let resultado = data.cards else { return }
//                print(resultado.map { $0.name })
//                print(resultado.map { $0.idCard })
//                print(resultado.map { $0.imageUrl })

            case .error(let anError):
                print("Error: \(anError)")
            }
        })
    }
}
