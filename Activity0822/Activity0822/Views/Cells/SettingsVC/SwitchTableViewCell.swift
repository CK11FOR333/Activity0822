//
//  SwitchTableViewCell.swift
//  0610
//
//  Created by Chris on 2019/7/5.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchTheme()
    func showLoginAlert()
}

class SwitchTableViewCell: UITableViewCell {

    weak var delegate: SwitchTableViewCellDelegate?

    var isDarkMode: Bool = false

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applyTheme()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func themeChanged(_ sender: UISwitch) {
        if isDarkMode {
            Theme.current = sender.isOn ? DarkTheme() : LightTheme()
            applyTheme()

            if sender.isOn {
                UserDefaults.standard.set(true, forKey: "kIsDarkTheme")
            } else {
                UserDefaults.standard.set(false, forKey: "kIsDarkTheme")
            }

            delegate?.switchTheme()
        } else {
            if loginManager.isLogin {
                //
            } else {
                if sender.isOn {
                    sender.setOn(false, animated: true)
                    delegate?.showLoginAlert()
                }
            }
        }
    }

    func applyTheme() {
        self.backgroundColor = Theme.current.tableViewCellBackgorund
        self.titleLabel.textColor = Theme.current.tableViewCellLightText
        self.switch.onTintColor = Theme.current.cornerButton
    }

}
