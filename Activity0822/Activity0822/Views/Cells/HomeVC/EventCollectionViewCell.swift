//
//  EventCollectionViewCell.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/26.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!

    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var groupNameLabel: UILabel!

    @IBOutlet weak var locationImageView: UIImageView!

    @IBOutlet weak var venueNameLabel: UILabel!

    @IBOutlet weak var attendeesLabel: UILabel!

    @IBOutlet weak var collectButton: UIButton!

    var event: Event? {
        didSet {
            if let event = event {
                dateLabel.text = event.localDate + " " + event.localTime

                nameLabel.text = event.name

                groupNameLabel.text = event.groupName

                venueNameLabel.text = event.venueName

                attendeesLabel.text = "\(event.yesRsvpCount) attendees"

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

extension EventCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.cornerRadius = 10
        cardView.shadowOffset = CGSize(width: 0, height: 2)
        cardView.shadowRadius = 2
        cardView.shadowOpacity = 0.5
        cardView.layer.masksToBounds = false

        locationImageView.image = UIImage(named: "tabbar_icon_map_default")

//        collectButton.tintColor = Theme.current.tint
        collectButton.setImage(UIImage(named: "navbar_icon_pick_default")?.withRenderingMode(.alwaysTemplate), for: .normal)
        collectButton.setImage(UIImage(named: "navbar_icon_pick_pressed"), for: .selected)
    }

}
