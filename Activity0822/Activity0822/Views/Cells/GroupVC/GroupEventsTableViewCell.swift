//
//  GroupEventsTableViewCell.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/9/2.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

protocol GroupEventsTableViewCellDelegate: class {
    func groupEventCellDidClick(at indexPath: IndexPath)
}

class GroupEventsTableViewCell: UITableViewCell {

    weak var delegate: GroupEventsTableViewCellDelegate?

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

        collectionView.register(nibWithCellClass: GroupEventCollectionViewCell.self)
    }

    func applyTheme() {
//        contentView.backgroundColor = Theme.current.tableViewBackground
//        eventTitleLabel.textColor = Theme.current.tableViewCellLightText
//        eventDescriptionLabel.textColor = Theme.current.tableViewCellLightText
//        collectionView.backgroundColor = Theme.current.tableViewBackground
    }

}

// MARK: - UICollectionView DataSource

extension GroupEventsTableViewCell: UICollectionViewDataSource {

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
        let cell: GroupEventCollectionViewCell = collectionView.dequeueReusableCell(withClass: GroupEventCollectionViewCell.self, for: indexPath)
        cell.event = cellModels![indexPath.item]
        cell.applyTheme()
        return cell
    }

}

// MARK: - UICollectionView Delegate

extension GroupEventsTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.groupEventCellDidClick(at: indexPath)
    }

}

// MARK: - UICollectionView FlowLayout

extension GroupEventsTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let width = collectionView.frame.size.width - 20
        //        return CGSize(width: width, height: 215)
        return CGSize(width: 300, height: 182)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
