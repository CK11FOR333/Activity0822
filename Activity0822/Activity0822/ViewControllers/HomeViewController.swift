//
//  ViewController.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/8/22.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var events: [Event] = []
    var groups: [Group] = []

    var refreshControl: UIRefreshControl!

    // MARK: IBOutlet

    @IBOutlet weak var tableView: UITableView!

}

extension HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getEvents()
        getGroups()
    }

}

extension HomeViewController {

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        tableView.register(nibWithCellClass: EventsTableViewCell.self)
        tableView.register(nibWithCellClass: GroupsTableViewCell.self)
    }

    func getEvents() {
        requestManager.getEvents { [weak self] (events) in
            guard let strongSelf = self else { return }
            strongSelf.events = events
            if #available(iOS 10.0, *) {
//                strongSelf.tableView.refreshControl?.endRefreshing()
            } else {
                // Fallback on earlier versions
//                strongSelf.refreshControl.endRefreshing()
            }

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                strongSelf.tableView.reloadData()
                strongSelf.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                //                    self?.applyTheme()
            })
        }
    }

    func getGroups() {
        requestManager.getGroups { [weak self] (groups) in
            guard let strongSelf = self else { return }
            strongSelf.groups = groups
            if #available(iOS 10.0, *) {
                //                strongSelf.tableView.refreshControl?.endRefreshing()
            } else {
                // Fallback on earlier versions
                //                strongSelf.refreshControl.endRefreshing()
            }

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                strongSelf.tableView.reloadData()
                strongSelf.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                //                    self?.applyTheme()
            })
        }
    }

}

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: EventsTableViewCell = tableView.dequeueReusableCell(withClass:  EventsTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.cellModels = self.events
            cell.delegate = self
            return cell
        } else {
            let cell: GroupsTableViewCell = tableView.dequeueReusableCell(withClass: GroupsTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.cellModels = self.groups
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 290
//        }
//        else {
//            return 348
//        }
//    }

}

extension HomeViewController: EventsTableViewCellDelegate {

    func eventCellDidClick(at indexPath: IndexPath) {
        let eventVC = UIStoryboard.main?.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        eventVC.event = self.events[indexPath.item]
        let navC = UINavigationController(rootViewController: eventVC)
        self.present(navC, animated: true, completion: nil)
    }

}
