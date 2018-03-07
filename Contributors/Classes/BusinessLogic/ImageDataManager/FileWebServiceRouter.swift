//
//  DownloadService.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/5/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import Moya

enum FileWebServiceRouter {
    case download(url: String, fileName: String?)

    var localLocation: URL {
        switch self {
        case .download(let url, let fileName):
            return FileLocator.futureFilePath(url: url, fileName: fileName)
        }
    }

    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, [.removePreviousFile, .createIntermediateDirectories]) }
    }
}

extension FileWebServiceRouter: TargetType {
    var baseURL: URL {
        switch self {
        case .download(let url, _):
            return URL(string: url)!
        }
    }
    var path: String {
        switch self {
        case .download(_, _):
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .download:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .download:
            return nil
        }
    }
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var task: Task {
        switch self {
        case .download:
            return .downloadDestination(downloadDestination)
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return nil
    }
}

struct FileProvider {
    static let provider = MoyaProvider<FileWebServiceRouter>()

    static func request(target: FileWebServiceRouter, progress: ProgressBlock?) -> Cancellable {
        return provider.request(target, progress: progress) { result in
            switch result {
            case let .success(response):
                let data = response.data
//                let json = JSON(data: data)
            case .failure(_): break

            }
        }
    }

}

