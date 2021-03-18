//
//  ViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit
import SnapKit

class ExpansionsViewController: UIViewController {
    var resultado = [CardSet]()

    lazy var expansionTableView: UITableView  = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expansions"
        navigationController?.navigationBar.prefersLargeTitles = true
        expansionTableView.register(ExpansionTableViewCell.self, forCellReuseIdentifier: "cell")

        setupViews()
        fetchExpansions()

    }


}

extension ExpansionsViewController {
    func fetchExpansions() {
        NetworkManager().requestExpansions(endpoint: .sets, parameters: .type, type: .expansion) { (result) in
            switch result {
            case .success(let data):
                guard let resultado = data.sets else { return }
                let expansion = resultado.sorted { $0.name < $1.name }
                self.resultado = expansion
                self.expansionTableView.reloadData()
            case .error(let anError):
                print("Error: \(anError)")
            }
        }
    }
}

extension ExpansionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultado.count
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExpansionTableViewCell else {
            return UITableViewCell()
        }
        cell.setupViews()
        cell.name.text = resultado[indexPath.row].name
        return cell
    }
}

extension ExpansionsViewController: ViewCode {
    func setupViewHierarchy() {
        view.addSubview(expansionTableView)
    }

    func setupConstraints() {
        expansionTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp_topMargin)
            make.bottom.equalTo(self.view.snp_bottomMargin)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
