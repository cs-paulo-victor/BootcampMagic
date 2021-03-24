//
//  ViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit

class ExpansionsViewController: CustomViewController {
    weak var delegate: ShowCardsProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        fetchExpansions()
    }

    override func loadView() {
        let expensionsView = ExpensionsView()
        expensionsView.delegate = self
        view = expensionsView
    }
}

extension ExpansionsViewController {
    func setupNavigationBar() {
        title = "Expansions"
    }

    func fetchExpansions() {
        NetworkManager().requestExpansions(endpoint: .sets, parameters: .type, type: .expansion) { (result) in
            switch result {
            case .success(let data):
                guard let response = data.sets, let expansionsView = (self.view as? ExpensionsView) else { return }
                let expansion = response.sorted { $0.name < $1.name }
                expansionsView.setupSections(expensions: expansion)
                expansionsView.expansionTableView.reloadData()
            case .error(let anError):
                print("Error: \(anError)")
            }
        }
    }
}

extension ExpansionsViewController: ShowCardsProtocol {
    func showCards(expantionCode: String) {
        let cardViewControler = CardsViewController()
        cardViewControler.showCards(expantionCode: expantionCode)
        self.navigationController?.pushViewController(cardViewControler, animated: true)
    }
}
