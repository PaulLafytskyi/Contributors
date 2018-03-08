//
//  ImageDataManager.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/5/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation
import Moya

//MARK:- Protocol

protocol ImageDataManager {
    func getImage(url: String, callback: @escaping SuccessImageBlock)
    var networkManager: NetworkManager { get }
    var cacheService: CacheService { get }
}

//MARK:- Implemetation

class ImageDataManagerImplemetation: ImageDataManager {
    var networkManager: NetworkManager
    var cacheService: CacheService

    init(networkManager: NetworkManager, cacheService: CacheService) {
        self.networkManager = networkManager
        self.cacheService = cacheService
    }

     func getImage(url: String, callback: @escaping SuccessImageBlock) {
        if let image = cacheService.getImage(forKey: url) {
            callback(image)
            return
        } else {
            networkManager.getImage(at: URL(string: url)!, success: { [weak self] (image) in
                self?.cacheService.add(image: image, forKey: url)
                callback(image)
            }, fail: { (error) in
                // Handle error
            })
        }
    }
}

// MARK:- Factory

class ImageDataManagerFactory {
    static func defaultImageDataManager() -> ImageDataManager {
        return ImageDataManagerImplemetation(networkManager: NetworkManagerFactory.defaultNetworkManager(), cacheService: CacheServiceFactory.defaultService())
    }
}

// MARK:- Locator

class ImageDataManagerLocator {
    private static var manager: ImageDataManager?

    static func populateWithApplicationModel(manager: ImageDataManager) {
        ImageDataManagerLocator.manager = manager
    }

    static var shared: ImageDataManager {
        return ImageDataManagerLocator.manager!
    }
}
