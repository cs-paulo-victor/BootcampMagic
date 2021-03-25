//
//  CardListView.swift
//  BootcampMagic
//
//  Created by paulo.victor.g.rosa on 22/03/21.
//

import Foundation
import UIKit
import Kingfisher

class CardsListView: UIView {

    // MARK: - Views
    lazy var cardListFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 18.32
        layout.minimumInteritemSpacing = 26
        return layout
    }()

    // swiftlint:disable line_length
    lazy var cardListCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: cardListFlowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cellCard")
        collection.register(HeaderSection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()

    // MARK: - Properties
    var sectionTitle = [String]()
    var arrayCars = [SectionCards]()
    let types = [
        "Artifact",
        "Conspiracy",
        "Creature",
        "Enchantment",
        "Instant",
        "Land",
        "Phenomenon",
        "Plane",
        "Planeswalker",
        "Scheme",
        "Sorcery",
        "Tribal",
        "Vanguard"
      ]

    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
            self.setupViews()
            self.cardListCollectionView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardsListView {
    func setupSections(cards: [Card]) {

        for type in types {
            var arrayCards = [Card]()
            for card in cards {
                if card.types.first == type {
                    arrayCards.append(card)
                    sectionTitle.append(type)
                }
            }
            if !arrayCards.isEmpty {
                arrayCars.append(SectionCards(type: type, cards: arrayCards))
            }
        }
        sectionTitle = sectionTitle.removingDuplicates()
    }
}
// MARK: - UICollectionViewDataSource

extension CardsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCars[section].cards.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {

        case UICollectionView.elementKindSectionHeader:

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HeaderSection
            var sectionCurrent = 0
            for type in sectionTitle {
                if indexPath.section == sectionCurrent {
                    headerView?.name.text = type
                }
                sectionCurrent += 1
            }
            return headerView ?? HeaderSection()
        default:
            assert(false, "Unexpected element kind")
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCard", for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }

        guard let imageCard = arrayCars[indexPath.section].cards[indexPath.row].imageUrl else {
            cell.imageView.image = UIImage(named: "imageLoading")
            return cell
        }

        let imageDefault = UIImage(named: "imageDefault")
        cell.imageView.kf.setImage(with: URL(string: imageCard), placeholder: imageDefault)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CardsListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 125.66)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = CGSize(width: collectionView.bounds.width, height: 100)
         return size
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
