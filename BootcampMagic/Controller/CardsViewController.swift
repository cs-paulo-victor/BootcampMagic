//
//  CardsViewViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 23/03/21.
//

import UIKit

class CardsViewController: CustomViewController {
    var expansionCode = String()
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
        NetworkManager().requestCards(endpoint: .cards, parameters: .set, code: expansionCode) { result in
            switch result {
            case .success(let data):
                guard let response = data.cards, let cardsView = (self.view as? CardsListView) else { return }
                cardsView.setupSections(cards: response)
                cardsView.cardListCollectionView.reloadData()
            case .error(let anError):
                print("Error: \(anError)")
            }
        }
    }
}
extension CardsViewController: ShowCardsProtocol {
    func showCards(expantionCode: String) {
        expansionCode = expantionCode
    }
}
