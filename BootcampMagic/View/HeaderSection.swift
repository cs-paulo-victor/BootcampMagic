//
//  HeaderSection.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 24/03/21.
//

import UIKit

class HeaderSection: UICollectionReusableView {
    var name: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = TextFont.body
        label.textColor = TextColor.body
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Autolayout

extension HeaderSection: ViewCode {
    func setupViewHierarchy() {
        addSubview(name)
    }

    func setupConstraints() {
        name.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerYWithinMargins)
            make.left.equalTo(self)
        }
    }

    func setupAditionalConfiguration() {
       self.backgroundColor = .clear
    }
}
