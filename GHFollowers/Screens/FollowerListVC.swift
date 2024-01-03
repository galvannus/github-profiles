//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Jorge Alejndro Marcial Galvan on 03/01/24.
//

import UIKit

class FollowerListVC: UIViewController {
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetWorkManager.shared.gerFollowers(for: userName, page: 1) { followers, errorMessage in
            guard let followers = followers else{
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
            print("Followers.count = \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
