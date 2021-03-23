//
//  ExpensionsView.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 22/03/21.
//

import Foundation
import UIKit
protocol ShowCardsProtocol: AnyObject {
    func showCards (expantionCode: String)
}
class ExpensionsView: UIView {

    // MARK: - Views
    lazy var expansionTableView: UITableView  = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Properties
    var result = [CardSet]()
    var sectionTitle = [Character]()
    var arraySection = [Section]()
    weak var delegate: ShowCardsProtocol?
    // MARK: - Life Cycle

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    // MARK: - Setup
extension ExpensionsView {
    func setupSections(expensions: [CardSet]) {
        var firstLetter = [Character]()

        for expension in expensions {
            firstLetter.append(expension.name.first ?? Character(""))
        }
        sectionTitle = firstLetter.removingDuplicates()

        for title in sectionTitle {
            var arrayExpantion = [CardSet]()

            for expension in (expensions.filter {$0.name.first == title }) {
                arrayExpantion.append(expension)

            }
            arraySection.append(Section(letter: title, expantions: arrayExpantion))
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ExpensionsView: UITableViewDataSource {
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

    // swiftlint:disable line_length
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExpansionTableViewCell else {
            return UITableViewCell()
        }
        cell.setupViews()
        cell.name.text = arraySection[indexPath.section].expantions[indexPath.row].name
        return cell
    }
}

extension ExpensionsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showCards(expantionCode: arraySection[indexPath.section].expantions[indexPath.row].code)
    }
}
// MARK: - Autolayout
extension ExpensionsView: ViewCode {
    func setupViewHierarchy() {
        addSubview(expansionTableView)
    }

    func setupConstraints() {
        expansionTableView.snp.makeConstraints { (make) in
            make.top.equalTo(snp_topMargin)
            make.bottom.equalTo(snp_bottomMargin)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    func setupAditionalConfiguration() {
        expansionTableView.register(ExpansionTableViewCell.self, forCellReuseIdentifier: "cell")
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
