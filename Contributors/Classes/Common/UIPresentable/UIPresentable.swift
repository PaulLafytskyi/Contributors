//
//  UIPresentable.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/7/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit

public protocol UIPresentable: AnyObject {
    var viewController: UIViewController { get }
}

public extension UIPresentable where Self: UIViewController  {
    var viewController: UIViewController {
        return self
    }
}
