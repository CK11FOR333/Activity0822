//
//  EventDetailTableViewCell.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/29.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class EventDetailTableViewCell: UITableViewCell {

    var event: Event? {
        didSet {
            if let event = event {
                let content = event.description.html2String

                //  文字排版
                let font = UIFont.systemFont(ofSize: 16)
                let textFont = [NSAttributedString.Key.font:font]
                // Define paragraph styling
                let paraStyle = NSMutableParagraphStyle()
                paraStyle.firstLineHeadIndent = 0
                paraStyle.paragraphSpacingBefore = 22
                paraStyle.lineHeightMultiple = 1.5
                paraStyle.alignment = .justified

                let attributedString = NSMutableAttributedString.init(string: content, attributes: textFont)

                // Apply paragraph styles to paragraph
                attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paraStyle, range: NSRange(location: 0,length: attributedString.length))
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Theme.current.tableViewCellLightText, range: NSMakeRange(0, attributedString.length))

                textView.attributedText = attributedString
                textView.isEditable = false
                textView.isScrollEnabled = false
                textView.dataDetectorTypes = .link

                self.resultTextViewHeight.constant = textView.sizeThatFits(textView.frame.size).height

                attendeesLabel.text = "Attendees (\(event.yesRsvpCount))"                
            }
        }
    }

    @IBOutlet weak var textView: MyTextView!

    @IBOutlet weak var resultTextViewHeight: NSLayoutConstraint!

    @IBOutlet weak var detailsLabel: UILabel!

    @IBOutlet weak var attendeesLabel: UILabel!

}

extension EventDetailTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension EventDetailTableViewCell {

    func applyTheme() {
        contentView.backgroundColor = Theme.current.tableViewBackground

        attendeesLabel.textColor = Theme.current.tableViewCellLightText
        detailsLabel.textColor = Theme.current.tableViewCellLightText
//        let attStr = textView.attributedText
//        let mutableAttStr = NSMutableAttributedString.init(string: attStr.)
//        mutableAttStr.addAttribute(NSAttributedString.Key.foregroundColor, value: Theme.current.tableViewCellLightText, range: NSMakeRange(0, mutableAttStr.length))
//        textView.attributedText = attStr
        textView.backgroundColor = Theme.current.tableViewBackground
    }

}

class MyTextView: UITextView {

    var topInset : CGFloat = 0
    var rightInset : CGFloat = -3
    var leftInset : CGFloat = -3
    var bottomInset : CGFloat = 0

    override func draw(_ rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)

        self.contentInset = insets

        self.setNeedsDisplay()
    }

}
