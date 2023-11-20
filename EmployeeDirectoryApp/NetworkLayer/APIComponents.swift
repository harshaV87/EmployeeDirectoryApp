//
//  APIComponents.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation

// protocol endpointprovider

protocol APIComponentsProvider {
    // properties
    var scheme: String {get}
    var baseURL: String {get}
    var path: String {get}
    var method: RequestMethod {get}
    var token: String {get}
    var queryItems: [URLQueryItem]? {get}
    var body: [String: Any]? {get}
    var mockFile: String? {get}
}

extension APIComponentsProvider {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "s3.amazonaws.com"
    }
    
    var token: String {
        return ""
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseURL
        urlComponents.path =  path
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            throw NetworkErrors.urlComponentsError
        }
        var urlRequest = URLRequest(url: url)
        // configuring the url request parms
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !token.isEmpty {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        // giving the request body
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw NetworkErrors.jsonSerialisationError(error.localizedDescription)
            }
        }
        // return that url request
        return urlRequest
    }
}
