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

    @IBOutlet weak var cardView: UIView!

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var categoryLabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var attendeesLabel: UILabel!

    @IBOutlet weak var collectButton: UIButton!

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

                //                var isCollected = false
                //                favoriteManager.isCafeCollected(cafe) { [weak self] (collected) in
                //                    isCollected = collected
                //
                //
                //                    self?.collectButton.isSelected = isCollected ? true : false
                //                    //                collectButton.tintColor = isCollected ? UIColor(hexString: "EB5757") : Theme.current.tint
                //                    self?.collectButton.tintColor = Theme.current.tint
                //                    //                if !isCollected {
                //                    //
                //                    //                }
                //                }
            }
        }
    }

}

extension GroupCollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.cornerRadius = 10
        cardView.shadowOffset = CGSize(width: 0, height: 2)
        cardView.shadowRadius = 2
        cardView.shadowOpacity = 0.5
        cardView.layer.masksToBounds = false

        //        collectButton.tintColor = Theme.current.tint
        collectButton.setImage(UIImage(named: "navbar_icon_pick_default")?.withRenderingMode(.alwaysTemplate), for: .normal)
        collectButton.setImage(UIImage(named: "navbar_icon_pick_pressed"), for: .selected)
    }
}
