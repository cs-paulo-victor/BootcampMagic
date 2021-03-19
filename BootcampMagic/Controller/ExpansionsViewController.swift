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
    var sectionTitle = [Character]()
    var arraySection = [Section]()

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
                self.setupSections(expensions: expansion)
                self.expansionTableView.reloadData()
            case .error(let anError):
                print("Error: \(anError)")
            }
        }
    }

    func setupSections(expensions: [CardSet]) {
        var firstLetter = [Character]()

        for expension in expensions {
            firstLetter.append(expension.name.first ?? Character(""))
        }
        sectionTitle = firstLetter.removingDuplicates()

        for title in sectionTitle {
            var array = [CardSet]()
            for exp in expensions {
                if exp.name.first == title {
                    array.append(exp)
                }
            }
            arraySection.append(Section(letter: title, expantions: array))
        }
    }
}

extension ExpansionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySection[section].expantions.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionCurrent = 0
        for letter in sectionTitle {
            if section == sectionCurrent {
                return String(letter)
            }
            sectionCurrent += 1
        }
        return ""
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExpansionTableViewCell else {
            return UITableViewCell()
        }
        cell.setupViews()
        cell.name.text = arraySection[indexPath.section].expantions[indexPath.row].name

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

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
