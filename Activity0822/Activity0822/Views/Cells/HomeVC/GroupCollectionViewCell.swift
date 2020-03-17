//
//  GroupCollectionViewCell.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/27.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class GroupCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentBackgroundView: UIView!

    @IBOutlet weak var shadowBackgroundView: UIView!

    @IBOutlet weak var cardView: UIView!

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var categoryLabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var attendeesLabel: UILabel!

    var group: Group? {
        didSet {
            if let group = group {

                if let url = URL(string: group.keyPhoto) {
                    let filter = ScaledToSizeFilter(size: imageView.frame.size)

                    imageView.af_setImage(
                        withURL: url,
                        placeholderImage: UIImage.init(color: .white, size: CGSize.zero),
                        filter: filter,
                        imageTransition: .crossDissolve(0.2)
                    )
                }

                categoryLabel.text = group.categoryName

                titleLabel.text = group.name

                attendeesLabel.text = "\(group.attendeesCount) attendees"
            }
        }
    }

}

extension GroupCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.cornerRadius = 10
        cardView.clipsToBounds = true

        shadowBackgroundView.cornerRadius = 10
        shadowBackgroundView.shadowOffset = CGSize(width: 0, height: 2)
        shadowBackgroundView.shadowRadius = 2
        shadowBackgroundView.shadowOpacity = 0.5
        shadowBackgroundView.clipsToBounds = false
    }

}

extension GroupCollectionViewCell {

    func applyTheme() {
        contentBackgroundView.backgroundColor = Theme.current.tableViewBackground

        cardView.backgroundColor = Theme.current.tableViewCellBackgorund
        cardView.shadowColor = Theme.current.shadow

        categoryLabel.textColor = Theme.current.tableViewCellLightText
        titleLabel.textColor = Theme.current.tableViewCellLightText
        attendeesLabel.textColor = Theme.current.tableViewCellLightText
    }

}
