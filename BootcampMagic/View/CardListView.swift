//
//  CardListView.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 22/03/21.
//

import Foundation
import UIKit

class CardsListView: UIView {

    // MARK: - Views
    lazy var cardListFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        return layout
    }()

    lazy var cardListCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: cardListFlowLayout)
        collection.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardsListView: ViewCode {
    func setupViewHierarchy() {
        addSubview(cardListCollectionView)
    }

    func setupConstraints() {
        cardListCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(snp_topMargin)
            make.bottom.equalTo(snp_bottomMargin)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

    }

}
