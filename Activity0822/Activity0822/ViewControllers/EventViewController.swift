//
//  EventViewController.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/28.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit
//import Kingfisher
import Alamofire
import AlamofireImage

class EventViewController: UIViewController {

    var event: Event?

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var bottomBackgroundView: UIView!

    @IBOutlet weak var bottomBackgroundShadowView: UIView!

    @IBOutlet weak var attendanceButton: UIButton!

    @IBOutlet weak var collectionButton: UIButton!

}

extension EventViewController {

    @IBAction func clickAttendanceButton(_ sender: UIButton) {
        if loginManager.isLogin {
            var isCollected = false
            favoriteManager.isEventAttended(self.event!) { [weak self] (collected) in
                guard let strongSelf = self else { return }

                isCollected = collected

                if isCollected {
                    favoriteManager.removeAttendedEvent(strongSelf.event!)
                } else {
                    favoriteManager.attendEvent(strongSelf.event!)
                }

                isCollected = !isCollected
                sender.isSelected = isCollected

            }

        } else {
            NotificationCenter.default.post(name: NSNotification.Name.loginFirst, object: nil, userInfo: nil)
        }
    }

    @IBAction func clickCollectionButton(_ sender: UIButton) {
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

}

extension EventViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupButtons()
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(showLoginAlert(_:)), name: NSNotification.Name.loginFirst, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyTheme()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

}

extension EventViewController {

    @objc fileprivate func showLoginAlert(_ notification: Notification) {
        appDelegate.presentAlertView(AlertTitle.loginFirst.rawValue, message: nil) {
            let loginVC = UIStoryboard.main?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(loginVC)
        }
    }

    func setupNavigationBar() {
        self.navigationItem.title = "Event"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: nil)

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
    }

    func setupTableView() {
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    func setupButtons() {
        attendanceButton.setBackgroundImage(UIImage.init(color: UIColor.white, size: attendanceButton.size), for: .normal)
        attendanceButton.setBackgroundImage(UIImage.init(color: LightTheme().accent, size: attendanceButton.size), for: .selected)
        attendanceButton.setTitleColor(LightTheme().accent, for: .normal)
        attendanceButton.setTitleColor(UIColor.white, for: .selected)
        attendanceButton.setTitle("Attend", for: .normal)
        attendanceButton.setTitle("Attended", for: .selected)
        attendanceButton.cornerRadius = 13
        attendanceButton.layer.borderColor = LightTheme().accent.cgColor
        attendanceButton.layer.borderWidth = 2
        attendanceButton.isSelected = false

        collectionButton.setBackgroundImage(UIImage(named: "navbar_icon_pick_default")?.withRenderingMode(.alwaysTemplate), for: .normal)
        collectionButton.setBackgroundImage(UIImage(named: "navbar_icon_pick_pressed"), for: .selected)
    }

    func updateUI() {
        if let event = event {

            var isCollected = false
            favoriteManager.isEventCollected(event) { [weak self] (collected) in
                guard let strongSelf = self else { return }

                isCollected = collected

                strongSelf.collectionButton.isSelected = isCollected ? true : false
            }

            var isAttened = false
            favoriteManager.isEventAttended(event) { [weak self] (attended) in
                guard let strongSelf = self else { return }

                isAttened = attended

                strongSelf.attendanceButton.isSelected = isAttened ? true : false
            }

            tableView.reloadData()
        }
    }

    fileprivate func applyTheme() {
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.reloadData()
        bottomBackgroundView.backgroundColor = Theme.current.tableViewCellBackgorund
        bottomBackgroundShadowView.backgroundColor = Theme.current.shadow
    }

}

extension EventViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: EventTitleTableViewCell = tableView.dequeueReusableCell(withClass:  EventTitleTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.event = self.event
            cell.applyTheme()
            return cell
        } else {
            let cell: EventDetailTableViewCell = tableView.dequeueReusableCell(withClass: EventDetailTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.event = self.event
            cell.applyTheme()
            return cell
        }
    }

}
