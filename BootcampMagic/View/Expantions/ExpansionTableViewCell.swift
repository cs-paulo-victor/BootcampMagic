//
//  ExpansionTableViewCell.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 18/03/21.
//

import UIKit

class ExpansionTableViewCell: UITableViewCell {

    var name: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = TextFont.body
        label.textColor = TextColor.body
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

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
