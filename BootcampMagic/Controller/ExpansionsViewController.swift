//
//  ViewController.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 16/03/21.
//

import UIKit
import SnapKit

class ExpansionsViewController: UIViewController {

    lazy var expansionTableView: UITableView  = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        return tableView
    }()

    var expansionManager = ExpansionsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expansions"
        expansionTableView.register(ExpansionTableViewCell.self, forCellReuseIdentifier: "cell")
        setupViews()
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
