//
//  CardsViewViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 23/03/21.
//

import UIKit

class CardsViewController: CustomViewController {
    var expensionCode = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCards()
    }

    override func loadView() {
        view = CardsListView()  
    }

}
extension CardsViewController {
    func fetchCards () {
        NetworkManager().requestCards(endpoint: .cards, parameters: .set, code: expensionCode) { result in
            switch result {
            case .success(let data):
                guard let resultado = data.cards else { return }
                print(resultado)
//                let expansion = resultado.sorted { $0.name < $1.name }
//                expansionsView.result = expansion
//                expansionsView.setupSections(expensions: expansion)
//                expansionsView.expansionTableView.reloadData()
            case .error(let anError):
                print("Error: \(anError)")
            }
        }
    }
}
extension CardsViewController: ShowCardsProtocol {
    func showCards(expantionCode: String) {
        expensionCode = expantionCode
        print(expantionCode)
    }
}
