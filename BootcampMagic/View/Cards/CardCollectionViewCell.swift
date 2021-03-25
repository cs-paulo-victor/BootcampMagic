//
//  CardCollectionViewCell.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 23/03/21.
//

import UIKit
import SnapKit

class CardCollectionViewCell: UICollectionViewCell {
    // MARK: - Views
    let imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Autolayout
extension CardCollectionViewCell: ViewCode {
    func setupViewHierarchy() {
        addSubview(imageView)
    }

    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)

        }
    }
}
