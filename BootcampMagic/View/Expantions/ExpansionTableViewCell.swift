//
//  ExpansionTableViewCell.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 18/03/21.
//

import UIKit

class ExpansionTableViewCell: UITableViewCell {
    // MARK: - Views
    var name: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = TextFont.body
        label.textColor = TextColor.body
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor()
        self.accessoryType = .disclosureIndicator

        self.tintColor = .white
    }

    fileprivate func backgroundColor() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        self.selectedBackgroundView = backgroundView
    }

}
    // MARK: - Autolayout

extension ExpansionTableViewCell: ViewCode {
    func setupViewHierarchy() {
        addSubview(name)
    }

    func setupConstraints() {
        name.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(14)
            make.bottom.equalTo(self).offset(-15)
            make.leading.equalTo(self).offset(16)
        }
    }

    func setupAditionalConfiguration() {
        self.backgroundColor = .clear
    }
}
