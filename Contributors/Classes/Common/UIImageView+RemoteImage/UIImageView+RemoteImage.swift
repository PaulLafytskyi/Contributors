//
//  UIImageView+RemoteImage.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/5/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit
import Moya

extension UIImageView {
    func set_remote_image(url: String) {
         ImageDataManagerLocator.shared.getImage(url: url, callback: {[weak self] (image) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.image = image
        })
    }
}
