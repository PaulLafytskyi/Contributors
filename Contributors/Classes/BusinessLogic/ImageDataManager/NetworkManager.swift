//
//  NetworkManager.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/5/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit
import Moya

typealias SuccessImageBlock = (_  image: UIImage) -> Void
typealias FailImageBlock = (Error) -> Void

//MARK:- Prtocol 

protocol NetworkManager {
    var apiService: GithubApiService { get }
    func getImage(at url: URL, success: @escaping SuccessImageBlock, fail: @escaping FailImageBlock)
}

//MARK:- Implementation

class NetworkManagerImplementation : NetworkManager {
    var apiService: GithubApiService

    init(apiService: GithubApiService) {
        self.apiService = apiService
    }

    func getImage(at url: URL, success: @escaping SuccessImageBlock, fail: @escaping FailImageBlock) {
        apiService.request(router: .downloadImage(url: url), success: { (pureImage) in
            guard let image = try? pureImage.mapImage() else {
                return
            }
            success(image)
        }) { (error) in
            fail(error)
        }
    }
}

//MARK:- Factory

class NetworkManagerFactory {
    static func defaultNetworkManager() -> NetworkManager {
        return NetworkManagerImplementation(apiService: GithubApiServiceImplementation(stubbing: false))
    }
}
