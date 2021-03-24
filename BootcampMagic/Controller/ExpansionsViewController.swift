//
//  ViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit
import SnapKit

class ExpansionsViewController: CustomViewController, ReachabilityObserverDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        try? addReachabilityObserver()
        setupNavigationBar()
        fetchExpansions()
    }

    override func loadView() {
        view = ExpensionsView()
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
                guard let resultado = data.sets, let expansionsView = (self.view as? ExpensionsView) else { return }
                let expansion = resultado.sorted { $0.name < $1.name }
                expansionsView.resultado = expansion
                expansionsView.setupSections(expensions: expansion)
                expansionsView.expansionTableView.reloadData()
            case .error(let anError):
                print("Error: \(anError)")
            }
        }
    }
}
