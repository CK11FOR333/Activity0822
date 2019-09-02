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

    @IBOutlet weak var attendanceButton: UIButton!

    @IBOutlet weak var collectionButton: UIButton!

}

extension EventViewController {

    @IBAction func clickAttendanceButton(_ sender: UIButton) {

    }

    @IBAction func clickCollectionButton(_ sender: UIButton) {

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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.hidesBottomBarWhenPushed = false
    }
}

extension EventViewController {

    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: nil)

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }

//        if #available(iOS 11.0, *) {
//            self.navigationController?.navigationBar.prefersLargeTitles = false
//        } else {
//            // Fallback on earlier versions
//        }
    }

//    @objc func close() {
//        self.dismiss(animated: true, completion: nil)
//    }

    func setupTableView() {
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    func setupButtons() {
        attendanceButton.cornerRadius = 13
    }

    func setupImageView() {
        if event != nil {
//            if let url = URL(string: event.) {
//                let filter = ScaledToSizeFilter(size: imageView.frame.size)
//
//                imageView.af_setImage(
//                    withURL: url,
//                    placeholderImage: UIImage.init(color: .white, size: CGSize.zero),
//                    filter: filter,
//                    imageTransition: .crossDissolve(0.2)
//                )
//            }
        }
    }

    func updateUI() {
        if event != nil {
            tableView.reloadData()
        }
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
            return cell
        } else {
            let cell: EventDetailTableViewCell = tableView.dequeueReusableCell(withClass: EventDetailTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.event = self.event
            return cell
        }
    }

}
