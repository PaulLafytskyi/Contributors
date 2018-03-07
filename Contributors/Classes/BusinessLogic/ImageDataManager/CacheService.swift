//
//  CacheService.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/5/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation
import AlamofireImage

protocol CacheService {
    var cache: AutoPurgingImageCache { get }
    func add(image: UIImage, forKey key: String)
    func getImage(forKey key: String) -> Image?
}

class CacheServiceImplementation: CacheService{
    var cache: AutoPurgingImageCache

    init(cache: AutoPurgingImageCache) {
        self.cache = cache
    }

    public func add(image: UIImage, forKey key: String) {
        cache.add(image, withIdentifier: key)
    }

    public func getImage(forKey key: String) -> Image? {
        return cache.image(withIdentifier: key)
    }
}

class CacheServiceFactory {
    static func defaultService() -> CacheService {
        return CacheServiceImplementation(cache: AutoPurgingImageCache())
    }
}
