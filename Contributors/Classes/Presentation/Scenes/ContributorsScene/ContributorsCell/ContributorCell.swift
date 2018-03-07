//
//  ContributorCell.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/4/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit

class ContributorCell: UITableViewCell, CellInitializable {
    @IBOutlet weak var loginNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        loginNameLabel.text = nil
        avatarImageView.image = nil
    }
}
