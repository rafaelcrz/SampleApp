//
//  Provider.swift
//  GitApp
//
//  Created by Chrystian Salgado on 20/06/23.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
}

protocol EndpointProtocol {
    var baseUrl: String? { get }
    var method: RequestMethod { get }
    var path: String { get }
}

enum Endpoint {
    case getGists(id: String)
}
extension Endpoint: EndpointProtocol {
    
    var baseUrl: String? {
        Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String
    }
    
    var method: RequestMethod {
        switch self {
        case .getGists:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case let .getGists(id):
            return "/gists/\(id)"
        }
    }
}
