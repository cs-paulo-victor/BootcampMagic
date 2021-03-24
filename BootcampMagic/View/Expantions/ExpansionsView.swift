//
//  ExpansionsView.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 22/03/21.
//

import Foundation
import UIKit
protocol ShowCardsProtocol: AnyObject {
    func showCards (expantionCode: String)
}
class ExpansionsView: UIView {

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
    var sectionTitle = [Character]()
    var sections = [SectionExpansion]()
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
extension ExpansionsView {
    func setupSections(expansions: [Expansion]) {
        var firstLetter = [Character]()

        for expansion in expansions {
            firstLetter.append(expansion.name.first ?? Character(""))
        }
        sectionTitle = firstLetter.removingDuplicates()

        for title in sectionTitle {
            var arrayExpantion = [Expansion]()

            for expansion in (expansions.filter {$0.name.first == title }) {
                arrayExpantion.append(expansion)

            }
            sections.append(SectionExpansion(letter: title, expantions: arrayExpantion))
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ExpansionsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].expantions.count
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
        cell.name.text = sections[indexPath.section].expantions[indexPath.row].name
        return cell
    }
}

extension ExpansionsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showCards(expantionCode: sections[indexPath.section].expantions[indexPath.row].code)
    }
}
// MARK: - Autolayout
extension ExpansionsView: ViewCode {
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
