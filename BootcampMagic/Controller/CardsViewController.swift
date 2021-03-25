//
//  CardsViewViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 23/03/21.
//

import UIKit

class CardsViewController: CustomViewController {
    var expensionCode = String()
    let service: NetworkManager

    required init(service: NetworkManager) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        service.requestCards(endpoint: .cards, parameters: .set, code: expensionCode) { result in
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
extension CardsViewController: ShowCardsDelegate {
    func didSelectExpansion(expantionCode: String) {
        expensionCode = expantionCode
    }
}
