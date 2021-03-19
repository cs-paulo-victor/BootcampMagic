//
//  ExpansionTableView.swift
//  BootcampMagic
//
//  Created by rayane.x.nobrega on 18/03/21.
//

import UIKit

extension ExpansionsViewController: UITableViewDelegate, UITableViewDataSource {

    convenience init(expansionManager: ExpansionsManager) {
        self.expansionManager = expansionManager
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection
    section: Int) -> CGFloat {
      return 50
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return expansionManager.expansionsSections.count
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return expansionManager.expansionsSections
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return expansionManager.expansionsSections[section].uppercased()
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.3333333333, green: 0.6392156863, blue: 0.9333333333, alpha: 1)
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
        header.textLabel?.textColor = UIColor.white
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userKey = expansionManager.expansionsSections[section]
        if let users = expansionManager.expansionsDictionaries[userKey] {
            return users.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath) as? ExpansionTableViewCell else {
            return ExpansionTableViewCell()
        }
        let userKey = expansionManager.expansionsSections[indexPath.section]
        if let users = expansionManager.expansionsDictionaries[userKey.uppercased()] {
            cell.configure(user: users[indexPath.row])
        }
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
}
