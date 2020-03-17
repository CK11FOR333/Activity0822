//
//  GroupEventCollectionViewCell.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/9/3.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class GroupEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentBackgroundView: UIView!

    @IBOutlet weak var cardView: UIView!

    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var locationImageView: UIImageView!

    @IBOutlet weak var venueNameLabel: UILabel!

    @IBOutlet weak var attendeesLabel: UILabel!

    @IBOutlet weak var collectButton: UIButton!

    @IBAction func clickCollectButton(_ sender: UIButton) {
        //        delegate?.didClickCollectButton(sender, at: indexPath)

        if loginManager.isLogin {
            var isCollected = false
            favoriteManager.isEventCollected(self.event!) { [weak self] (collected) in
                guard let strongSelf = self else { return }

                isCollected = collected

                if isCollected {
                    favoriteManager.removeFavoriteEvent(strongSelf.event!)
                } else {
                    favoriteManager.addFavoriteEvent(strongSelf.event!)
                }

                isCollected = !isCollected
                sender.isSelected = isCollected
                if isCollected {
                    sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: {
                        sender.transform = .identity
                    }, completion: nil)
                }
            }

        } else {
            NotificationCenter.default.post(name: NSNotification.Name.loginFirst, object: nil, userInfo: nil)
        }
    }

    var event: Event? {
        didSet {
            if let event = event {
                dateLabel.text = event.localDate + " " + event.localTime

                nameLabel.text = event.name

                venueNameLabel.text = event.venueName

                attendeesLabel.text = "\(event.yesRsvpCount) attendees"

                var isCollected = false
                favoriteManager.isEventCollected(event) { [weak self] (collected) in
                    guard let strongSelf = self else { return }

                    isCollected = collected

                    strongSelf.collectButton.isSelected = isCollected ? true : false
                }
            }
        }
    }

}

extension GroupEventCollectionViewCell {

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

extension GroupEventCollectionViewCell {

    func applyTheme() {
//        contentBackgroundView.backgroundColor = Theme.current.tableViewBackground
//
//
//        cardView.backgroundColor = Theme.current.tableViewCellBackgorund
//        cardView.shadowColor = Theme.current.shadow
//
//        dateLabel.textColor = Theme.current.tableViewCellLightText
//        nameLabel.textColor = Theme.current.tableViewCellLightText
//        groupNameLabel.textColor = Theme.current.tableViewCellLightText
//        venueNameLabel.textColor = Theme.current.tableViewCellLightText
//        attendeesLabel.textColor = Theme.current.tableViewCellLightText
//
//        locationImageView.tintColor = Theme.current.tint
    }

}
