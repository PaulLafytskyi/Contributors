//
//  Configurations.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/3/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Foundation

protocol BaseUrl {
    static var url: URL { get }
}

protocol Predefined {
    static var repoOwner: String { get }
    static var repoName: String { get }
}

struct Configurations: BaseUrl, Predefined {

    static var url: URL {
        return URL(string: "https://api.github.com")!
    }

    static var repoName: String {
        return "alamofire"
    }

    static var repoOwner: String {
        return "alamofire"
    }
}
