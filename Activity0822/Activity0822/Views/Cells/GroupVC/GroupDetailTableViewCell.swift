//
//  GroupDetailTableViewCell.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/9/2.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class GroupDetailTableViewCell: UITableViewCell {

    var group: Group? {
        didSet {
            if let group = group {
                let content = group.description.html2String

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
                //                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: NSMakeRange(0, attributedString.length))

                textView.attributedText = attributedString
                textView.isEditable = false
                textView.isScrollEnabled = false
                textView.dataDetectorTypes = .link

                self.resultTextViewHeight.constant = textView.sizeThatFits(textView.frame.size).height
            }
        }
    }

    @IBOutlet weak var textView: MyTextView!

    @IBOutlet weak var resultTextViewHeight: NSLayoutConstraint!

}

extension GroupDetailTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
