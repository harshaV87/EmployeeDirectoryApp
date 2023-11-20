//
//  MockApiHelper.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/19/23
//

import Foundation
import Combine

protocol NetworkMockable: AnyObject {
    var bundleForFile: Bundle { get }
    func loadJSONFromFile<T: Decodable>(mockFileName: String, type: T.Type) -> T
}

extension NetworkMockable {
    var bundleForFile: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSONFromFile<T: Decodable>(mockFileName: String, type: T.Type) -> T {
        guard let path = bundleForFile.url(forResource: mockFileName, withExtension: "json") else {
            // gracefully crash - only for tests cases
            fatalError("Failed to load JSON")
        }
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)
            return decodedObject
        } catch {
            // gracefully crash - only for tests cases
            fatalError("Failed to decode loaded JSON")
        }
    }
}

class MockApiClient: NetworkMockable, APIServiceProtocol {
    // returning from the file json injection 
    func getEmployeeListRequest<T>(apiEndPoint: APIComponentsProvider, responseModel: T.Type) -> AnyPublisher<T, ApiError> where T : Decodable {
        return Just(loadJSONFromFile(mockFileName: apiEndPoint.mockFile ?? "", type: responseModel.self) as T)
                    .setFailureType(to: ApiError.self)
                    .eraseToAnyPublisher()
    }
}
