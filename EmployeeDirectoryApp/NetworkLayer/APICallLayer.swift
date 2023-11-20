//
//  APICallLayer.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation
import Combine

// Request

enum RequestMethod: String {
    case get = "GET"
    // we can extend it like as such
    // case put = "PUT"
}

protocol APIServiceProtocol {
    func getEmployeeListRequest<T: Decodable>(apiEndPoint: APIComponentsProvider, responseModel: T.Type) -> AnyPublisher<T, ApiError>
}
