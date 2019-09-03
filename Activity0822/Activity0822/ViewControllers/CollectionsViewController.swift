//
//  CollectionsViewController.swift
//  Activity0822
//
//  Created by Christmas Kay on 2019/9/3.
//  Copyright © 2019 Christmas Kay. All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController {

    var cellModels: [Event]? {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var loginView: UIView!

    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.cornerRadius = 20
        }
    }

    @IBAction func clickLoginButton(_ sender: UIButton) {
        let loginVC = UIStoryboard.main?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC)
    }

}

extension CollectionsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyTheme()
    }

}

extension CollectionsViewController {

    func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "kIsDarkTheme") ? .default : .black

        navigationController?.navigationBar.backgroundColor = Theme.current.navigationBar
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBar
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = Theme.current.tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.tint]
    }

    fileprivate func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.isScrollEnabled = true
        //        collectionView.isPagingEnabled = true

        collectionView.register(nibWithCellClass: EventCollectionViewCell.self)
    }

    fileprivate func checkLogin() {
        if loginManager.isLogin {
            loginView.isHidden = true
            getCollections()
        } else {
            loginView.isHidden = false
        }
    }

    fileprivate func applyTheme() {
        collectionView.backgroundColor = Theme.current.tableViewBackground

        setupNavigationBar()
    }

    fileprivate func getCollections() {
        favoriteManager.getEvents { [weak self] (collected) in
            guard let strongSelf = self else { return }
            strongSelf.cellModels = collected
        }
    }

}

// MARK: - UICollectionView DataSource

extension CollectionsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellModels = cellModels, !cellModels.isEmpty else {
            return 0
        }
        return cellModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EventCollectionViewCell = collectionView.dequeueReusableCell(withClass: EventCollectionViewCell.self, for: indexPath)
        cell.event = cellModels![indexPath.item]
        cell.applyTheme()
        //        cell.delegate = self
        return cell
    }

}

// MARK: - UICollectionView Delegate

extension CollectionsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.delegate?.eventCellDidClick(at: indexPath)
    }

}

// MARK: - UICollectionView FlowLayout

extension CollectionsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dev = UIDevice.current.userInterfaceIdiom
        let screenWidth = UIScreen.main.bounds.width
        if dev == .phone {
            return CGSize(width: screenWidth - 20, height: 215)
        } else if dev == .pad {
            return CGSize(width: (screenWidth - 20) / 2, height: 215)
        } else {
            return CGSize(width: 300, height: 215)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
