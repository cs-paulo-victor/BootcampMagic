//
//  ViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit

class ExpansionsViewController: CustomViewController,  ReachabilityObserverDelegate {
    weak var delegate: ShowCardsDelegate?
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
                                      message: "A lista de extensões necessita da internet.",
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("Ok",
                                                              comment: "Entendeu que está sem internet"),
                                     style: .default,
                                     handler: nil)
        okButton.setValue(TextColor.buttonTabBarSelect, forKey: "titleTextColor")
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ExpansionsViewController {
    func setupNavigationBar() {
        title = "Expansions"
    }

    func fetchExpansions() {
        service.requestExpansions(endpoint: .sets, parameters: .type, type: .expansion) { (result) in
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

extension ExpansionsViewController: ShowCardsDelegate {
    func didSelectExpansion(expantionCode: String) {
        let cardViewControler = CardsViewController(service: service)
        cardViewControler.didSelectExpansion(expantionCode: expantionCode)
        self.navigationController?.pushViewController(cardViewControler, animated: true)
    }
}
