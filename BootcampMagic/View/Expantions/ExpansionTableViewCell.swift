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

    var creatCustomSeparator: UIView = {
        let bottom = UIView()
        bottom.backgroundColor = .white
        return bottom
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension ExpansionTableViewCell: ViewCode {
    func setupViewHierarchy() {
        addSubview(name)
        addSubview(creatCustomSeparator)
    }

    func setupConstraints() {
        name.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(14)
            make.bottom.equalTo(self).offset(-15)
            make.leading.equalTo(self).offset(16)
        }
        creatCustomSeparator.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.leading.equalTo(self).offset(16)
            make.height.equalTo(2)
            make.trailing.equalTo(self).offset(-16)
        }
    }

    func setupAditionalConfiguration() {
        self.backgroundColor = .clear
    }
}
