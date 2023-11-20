//
//  NetworkError.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation

enum NetworkErrors: Error {
    case urlComponentsError
    case otherError
    case redirectionError
    case serverError
    case clientError
    case jsonSerialisationError(String)
    case jsonURLresponseError(String)
    case responseStatusCodeFailError(String)
    case defaultStatusCodeFailError
    case combineApiErrorFailure
}
