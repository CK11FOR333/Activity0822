//
//  EventTitleTableViewCell.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/29.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class EventTitleTableViewCell: UITableViewCell {

    var event: Event? {
        didSet {
            if let event = event {
                eventTitleLabel.text = event.name
                groupTitleLabel.text = event.groupName
                dateLabel.text = event.localDate + " " + event.localTime
                addressLabel.text = event.venueName
            }
        }
    }

    @IBOutlet weak var eventTitleLabel: UILabel!

    @IBOutlet weak var groupTitleLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var addressLabel: UILabel!

}

extension EventTitleTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension EventTitleTableViewCell {

    func applyTheme() {
        contentView.backgroundColor = Theme.current.tableViewBackground
        eventTitleLabel.textColor = Theme.current.tableViewCellLightText
        groupTitleLabel.textColor = Theme.current.tabBarUnSelected
        dateLabel.textColor = Theme.current.dateLabel
        addressLabel.textColor = Theme.current.tableViewCellSelectedBackground
    }

}
