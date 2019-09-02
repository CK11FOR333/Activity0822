//
//  GroupTitleTableViewCell.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/9/2.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class GroupTitleTableViewCell: UITableViewCell {

    var group: Group? {
        didSet {
            if let group = group {
                groupTitleLabel.text = group.name
                categoryLabel.text = group.categoryName
                attendeesLabel.text = "Members (\(group.attendeesCount))"
            }
        }
    }

    @IBOutlet weak var groupTitleLabel: UILabel!

    @IBOutlet weak var categoryLabel: UILabel!

    @IBOutlet weak var attendeesLabel: UILabel!

}

extension GroupTitleTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
