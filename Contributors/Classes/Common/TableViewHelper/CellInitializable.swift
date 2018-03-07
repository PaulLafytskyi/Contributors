//
//  CellInitializable.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/4/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit

public protocol CellInitializable: AnyObject {
    static func reuseIdentifier() -> String
    static func nib() -> UINib
}

public extension CellInitializable where Self: UITableViewCell {
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
