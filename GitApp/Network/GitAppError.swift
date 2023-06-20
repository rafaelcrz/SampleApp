//
//  GitAppError.swift
//  GitApp
//
//  Created by Chrystian Salgado on 20/06/23.
//

import Foundation

enum GitAppError: Error {
    case urlError
    case parseError
    case requestError
}
