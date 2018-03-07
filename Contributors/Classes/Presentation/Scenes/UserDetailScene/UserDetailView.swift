//
//  UserDetailView.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/7/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit

protocol UserDetailView: AnyObject {
    func configure(image: String, name: String)
}

class UserDetailViewController: UIViewController, UserDetailView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!

    var presenter: UserDetailViewPresenter!

    //MARK:- Init

    init() {
        super.init(nibName: "UserDetailView", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidReady()
    }

    //MARK:- UserDetailView

    func configure(image: String, name: String) {
        avatarImageView.set_remote_image(url: image)
        nameLabel.text = name
    }
}
