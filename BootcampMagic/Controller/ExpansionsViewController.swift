//
//  ViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit

class ExpansionsViewController: CustomViewController {

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
                guard let resultado = data.sets, let expansionsView = (self.view as? ExpensionsView) else { return }
                let expansion = resultado.sorted { $0.name < $1.name }
                expansionsView.result = expansion
                expansionsView.setupSections(expensions: expansion)
                expansionsView.expansionTableView.reloadData()
            case .error(let anError):
                print("Error: \(anError)")
            }
        }
    }
}

extension ExpansionsViewController: ShowCardsProtocol {
    func showCards() {
        self.navigationController?.pushViewController(CardsViewViewController(), animated: true)

    }
}
