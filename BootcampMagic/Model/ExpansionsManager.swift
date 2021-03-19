//
//  ExpansionsManager.swift
//  BootcampMagic
//
//  Created by rayane.x.nobrega on 18/03/21.
//

import UIKit

public class ExpansionsManager {
    public var resultado = [CardSet]()

    private var expansionsSection = [String]()
    private var expansionsDictionary = [String: [CardSet]]()

    init() {
        expansionsUser()
    }

    private func expansionsUser() {
        for user in resultado {
            let key = "\(user.name[user.name.startIndex])".uppercased()
            if var userValue = self.expansionsDictionary[key] {
                userValue.append(user)
            } else {
                self.expansionsDictionary[key] = [user]
            }
            self.expansionsSection = [String](self.expansionsDictionary.keys).sorted()
        }
    }

    public var expansionsSections: [String] {
        return expansionsSection
    }

    public var expansionsDictionaries: [String: [CardSet]] {
        return expansionsDictionary
    }

    public var userCount: Int {
        return resultado.count
    }

    public func addUser(user: CardSet) {
        resultado.append(user)
    }

    public func getUser(at index: Int) -> CardSet {
        return resultado[index]
    }

    public func deleteUser(at index: Int) {
        resultado.remove(at: index)
    }
}

extension ExpansionsManager {
    func fetchExpansions() {
        NetworkManager().requestExpansions(endpoint: .sets, parameters: .type, type: .expansion) { (result) in
            switch result {
            case .success(let data):
                guard let resultado = data.sets else { return }
                let expansion = resultado.sorted { $0.name < $1.name }
                self.resultado = expansion
//                self.tableView.reloadData()
            case .error(let anError):
                print("Error: \(anError)")
            }
        }
    }
}
