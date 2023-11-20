//
//  APIListProvider.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation

enum EmployeeDirectoryEndPointsList: APIComponentsProvider {
    
    //https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json
    
    // different end points from base url
    case getEmployeeListWithDetails
    
    var path: String {
        switch self {
        case .getEmployeeListWithDetails:
            return "/sq-mobile-interview/employees.json"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getEmployeeListWithDetails:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getEmployeeListWithDetails:
            return nil
        }
    }
    
    var body: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var mockFile: String? {
        // MARK: INJECT INTO THE MOCK TO GET THE TESTS DONE
        switch self {
        case .getEmployeeListWithDetails:
            return "EmployeeList"
        }
    }
}
