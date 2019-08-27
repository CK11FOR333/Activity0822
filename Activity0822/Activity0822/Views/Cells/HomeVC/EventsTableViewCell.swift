//
//  EventsTableViewCell.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/26.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    var cellModels: [Event]? {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.isScrollEnabled = true
//        collectionView.isPagingEnabled = true

        collectionView.register(nibWithCellClass: EventCollectionViewCell.self)
    }
    
}

// MARK: - UICollectionView DataSource

extension EventsTableViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellModels = cellModels, !cellModels.isEmpty else {
            return 0
        }
        return cellModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EventCollectionViewCell = collectionView.dequeueReusableCell(withClass: EventCollectionViewCell.self, for: indexPath)
        cell.event = cellModels![indexPath.item]
        return cell
    }

}

// MARK: - UICollectionView Delegate

extension EventsTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

}

// MARK: - UICollectionView FlowLayout

extension EventsTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.size.width - 20
//        return CGSize(width: width, height: 215)
        return CGSize(width: 300, height: 215)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
