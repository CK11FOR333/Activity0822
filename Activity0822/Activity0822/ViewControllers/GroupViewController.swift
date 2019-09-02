//
//  GroupViewController.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/9/2.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import AlamofireImage

class GroupViewController: UIViewController {

    var group: Group?

    var events: [Event]?

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var tableHeaderImageView: UIImageView!

    @IBOutlet weak var tableHeaderImageViewHeight: NSLayoutConstraint!
    
}

extension GroupViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupImageView()
        setupTableView()
        updateUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        refreshHeaderView()
    }

}

extension GroupViewController {

    func refreshHeaderView() {
        let header = self.tableView.tableHeaderView
        header!.frame.size.height = header!.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        self.tableView.tableHeaderView = header
    }

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

        tableView.register(nibWithCellClass: GroupEventsTableViewCell.self)
    }

    func setupImageView() {
        if let group = group {
            if let url = URL(string: group.keyPhoto) {
                let filter = ScaledToSizeFilter(size: tableHeaderImageView.frame.size)

                tableHeaderImageView.af_setImage(
                    withURL: url,
                    placeholderImage: UIImage.init(color: .white, size: CGSize.zero),
                    filter: filter,
                    imageTransition: .crossDissolve(0.2)
                )

//                let processor = DownsamplingImageProcessor(size: tableHeaderImageView.frame.size)
                tableHeaderImageView.kf.setImage(with: url, placeholder: UIImage(named: "image-placeholder-icon"), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                    guard let image = image else { return }
                    self.tableHeaderImageViewHeight.constant = self.tableHeaderImageView.frame.width * image.size.height/image.size.width
                    self.refreshHeaderView()
                }
            }
        }
    }

    func updateUI() {
        if let group = group {
            requestManager.getEvents {  [weak self] (events) in
                guard let strongSelf = self else { return }

                var groupEvents: [Event] = []
                for event in events {
                    for nextEvent in group.nextEvents where event.id == nextEvent {
                        groupEvents.append(event)
                    }
                }
                strongSelf.events = groupEvents

                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                    strongSelf.tableView.reloadData()
//                    strongSelf.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    //                    self?.applyTheme()
                })
            }
        }
    }

}

extension GroupViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: GroupTitleTableViewCell = tableView.dequeueReusableCell(withClass:  GroupTitleTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.group = self.group
            return cell
        } else if indexPath.row == 1 {
            let cell: GroupDetailTableViewCell = tableView.dequeueReusableCell(withClass: GroupDetailTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.group = self.group
            return cell
        } else {
            let cell: GroupEventsTableViewCell = tableView.dequeueReusableCell(withClass: GroupEventsTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.cellModels = self.events
            cell.delegate = self
            return cell
        }
    }

}

extension GroupViewController: GroupEventsTableViewCellDelegate {

    func groupEventCellDidClick(at indexPath: IndexPath) {
        let eventVC = UIStoryboard.main?.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        eventVC.event = self.events![indexPath.item]
        eventVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(eventVC, animated: true)
    }

}
