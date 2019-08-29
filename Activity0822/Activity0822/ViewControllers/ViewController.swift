//
//  ViewController.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/28.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var htmlLabel: UILabel!

    @IBOutlet weak var htmlTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let str = "<p>地點：波希米亞人咖啡館<br/>地址：台北市大同區長安西路76號B1<br/>（台北車站與中山站間的中山地下街 R4 出口）</p> <p>What you can do at H4 :<br/>1. Code your code.<br/>2. Talk about OS, Programming, Hacking skills, Gossiping ...<br/>3. Meet new friends ~<br/>4. Hack and share anything !</p> <p>See details :<br/><a href='http://www.hackingthursday.org/' class='linkified'>http://www.hackingthursday.org/</a></p> <p>Weekly Share :<br/><a href='http://sync.in/h4' class='linkified'>http://sync.in/h4</a></p> "


        htmlLabel.attributedText = str.html2AttributedString
        htmlTextView.attributedText = str.html2AttributedString
//        htmlTextView.text = str.html2String
    }

}

extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
