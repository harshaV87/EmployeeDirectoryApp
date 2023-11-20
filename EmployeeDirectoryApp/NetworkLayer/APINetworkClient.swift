//
//  APINetworkClient.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation
import Combine

final class APIClient: APIServiceProtocol {
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 300
        return URLSession(configuration: configuration)
    }
    
    func getEmployeeListRequest<T>(apiEndPoint: APIComponentsProvider, responseModel: T.Type) -> AnyPublisher<T, ApiError> where T : Decodable {
        do {
            return session.dataTaskPublisher(for: try apiEndPoint.asURLRequest()).tryMap { output in
                return try self.decodeAndManageResponse(data: output.data, response: output.response)
            }.mapError{
                $0 as? ApiError ?? ApiError(errorCode: "API failure", message: "error : \($0.localizedDescription)")
            }.catch({ errorOut in
                return AnyPublisher<T, ApiError>(Fail(error: errorOut))
            })
            .eraseToAnyPublisher()
        } catch let error as ApiError{
            return AnyPublisher<T, ApiError>(Fail(error: error))
        } catch {
            return AnyPublisher<T, ApiError>(Fail(error: ApiError(
                errorCode: "API failure",
                message: "error : \(error.localizedDescription)"
            )))
        }
    }
    
    private func decodeAndManageResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkErrors.jsonURLresponseError("Invalid HTTP response")
        }
        switch response.statusCode {
            // here is where u can add different status codes so that u can account for all kinds of errors
        case 200...299 :
            // success
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkErrors.responseStatusCodeFailError(error.localizedDescription)
            }
        case 300...399 :
            // redirect
            guard let decodedError = try? JSONDecoder().decode(ApiError.self, from: data) else {
                throw NetworkErrors.redirectionError
            }
            throw decodedError
        case 400...499 :
            guard let decodedError = try? JSONDecoder().decode(ApiError.self, from: data) else {
                throw NetworkErrors.clientError
            }
            throw decodedError
            // client
        case 500...599 :
            // server
            guard let decodedError = try? JSONDecoder().decode(ApiError.self, from: data) else {
                throw NetworkErrors.serverError
            }
            throw decodedError
        default:
            guard let decodedError = try? JSONDecoder().decode(ApiError.self, from: data) else {
                throw NetworkErrors.defaultStatusCodeFailError
            }
            if response.statusCode == 403 && decodedError.errorCode == "expired token" {
                // here we can have a notification center to log the user out
            }
            throw NetworkErrors.defaultStatusCodeFailError
        }
    }
}
