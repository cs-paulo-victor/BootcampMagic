//
//  ViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit

class ExpansionsViewController: CustomViewController,  ReachabilityObserverDelegate {
    weak var delegate: ShowCardsProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        try? addReachabilityObserver()
        setupNavigationBar()
        fetchExpansions()
    }

    override func loadView() {
        let expensionsView = ExpensionsView()
        expensionsView.delegate = self
        view = expensionsView
    }
    deinit {
      removeReachabilityObserver()
    }

    func reachabilityChanged(_ isReachable: Bool) {
        if !isReachable {
            alert()
        }
    }

    func alert() {
        let alert = UIAlertController(title: "Falha na conexão com a internet",
                                      message: "A lista de extensões necessita da internet, mas é possivel ver as favoritadas.",
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("Ok",
                                                              comment: "Entendeu que está sem internet"),
                                     style: .default,
                                     handler: nil)
        okButton.setValue(TextColor.button, forKey: "titleTextColor")
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
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
