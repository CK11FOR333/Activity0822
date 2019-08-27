//
//  GroupsTableViewCell.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/27.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    var cellModels: [Group]? {
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

        collectionView.register(nibWithCellClass: GroupCollectionViewCell.self)
    }
    
}

// MARK: - UICollectionView DataSource

extension GroupsTableViewCell: UICollectionViewDataSource {

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
        let cell: GroupCollectionViewCell = collectionView.dequeueReusableCell(withClass: GroupCollectionViewCell.self, for: indexPath)
        cell.group = cellModels![indexPath.item]
        return cell
    }

}

// MARK: - UICollectionView Delegate

extension GroupsTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

}

// MARK: - UICollectionView FlowLayout

extension GroupsTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.size.width - 20
//        return CGSize(width: width, height: 215)
        return CGSize(width: 235, height: 280)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}
