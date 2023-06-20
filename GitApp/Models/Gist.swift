//
//  Gist.swift
//  GitApp
//
//  Created by Chrystian Salgado on 20/06/23.
//

import Foundation

struct Gist: Codable {
    var description: String?
    var owner: Owner?
}

struct Owner: Codable {
    var login: String?
}
