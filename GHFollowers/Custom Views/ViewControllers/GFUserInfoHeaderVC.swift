//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Jorge Alejndro Marcial Galvan on 13/01/24.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    let avatarImaView = GFAvatarImageView(frame: .zero)
    let userNameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSeccondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSeccondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)

    var user: User!

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        layoutUI()
        configureUIElements()
    }

    func configureUIElements() {
        avatarImaView.downloadImage(from: user.avatarUrl)
        userNameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No location"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3

        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }

    func addSubView() {
        view.addSubview(avatarImaView)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }

    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImaView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImaView.widthAnchor.constraint(equalToConstant: 90),
            avatarImaView.heightAnchor.constraint(equalToConstant: 90),

            userNameLabel.topAnchor.constraint(equalTo: avatarImaView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImaView.trailingAnchor, constant: textImagePadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),

            nameLabel.centerYAnchor.constraint(equalTo: avatarImaView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImaView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            locationImageView.bottomAnchor.constraint(equalTo: avatarImaView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImaView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),

            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),

            bioLabel.topAnchor.constraint(equalTo: avatarImaView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImaView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
