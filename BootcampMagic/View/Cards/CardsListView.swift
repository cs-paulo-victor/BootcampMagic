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
        layout.minimumLineSpacing = 18.32
        layout.minimumInteritemSpacing = 26
        return layout
    }()

    lazy var cardListCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: cardListFlowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cellCard")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
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
extension CardsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    // swiftlint:disable line_length
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCard", for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageView.backgroundColor = .black
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CardsListView: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 90, height: 125.66)
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
            make.leading.equalTo(self).offset(26)
            make.trailing.equalTo(self).offset(-27)
        }
    }
}
