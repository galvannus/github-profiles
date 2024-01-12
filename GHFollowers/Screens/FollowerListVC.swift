//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Jorge Alejndro Marcial Galvan on 03/01/24.
//

import UIKit

class FollowerListVC: UIViewController {
    enum Section {
        case main
    }

    var userName: String!
    var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: userName, page: page)
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }

    func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetWorkManager.shared.gerFollowers(for: username, page: page) { [weak self] result in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case let .success(followers):
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                self.updateData()

            case let .failure(error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            // Get cell configured
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            // Configuring each cell with follower
            cell.set(follower: follower)

            return cell
        })
    }

    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: userName, page: page)
        }
    }
}
