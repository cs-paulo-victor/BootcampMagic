//
//  ExpensionsView.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 22/03/21.
//

import Foundation
import UIKit
protocol ShowCardsDelegate: AnyObject {
    func didSelectExpansion (expantionCode: String)
}
class ExpensionsView: UIView {

    // MARK: - Views
    lazy var expansionTableView: UITableView  = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 16)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Properties
    var sectionTitle = [Character]()
    var sections = [SectionExpension]()
    weak var delegate: ShowCardsDelegate?

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
    func setupSections(expensions: [Expension]) {
        var firstLetter = [Character]()

        for expension in expensions {
            firstLetter.append(expension.name.first ?? Character(""))
        }
        sectionTitle = firstLetter.removingDuplicates()

        for title in sectionTitle {
            var arrayExpantion = [Expension]()

            for expension in (expensions.filter {$0.name.first == title }) {
                arrayExpantion.append(expension)

            }
            sections.append(SectionExpension(letter: title, expantions: arrayExpantion))
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ExpensionsView: UITableViewDataSource {
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath) as? ExpansionTableViewCell else {
            return UITableViewCell()
        }
        cell.setupViews()
        cell.name.text = sections[indexPath.section].expantions[indexPath.row].name
        return cell
    }
}

extension ExpensionsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectExpansion(expantionCode: sections[indexPath.section].expantions[indexPath.row].code)
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
