//
//  EmployeeDirectoryAppTests.swift
//  EmployeeDirectoryAppTests
//
//  Created by harsha BV on 9/20/23.
//

import XCTest
import Combine
@testable import EmployeeDirectoryApp

class EmployeeDirectoryAppTests: XCTestCase {
    
    var sut : MockApiClient!
    
    private var cancellables: Set<AnyCancellable> = []
    
    private func getMockApiResponse(completions: @escaping([Employee]?, Error?) -> ()){
        
        sut.getEmployeeListRequest(apiEndPoint: EmployeeDirectoryEndPointsList.getEmployeeListWithDetails, responseModel: EmployeeListResponse.self).receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                   completions(nil, error)
                }
            } receiveValue: { employeeListDetail in
                completions(employeeListDetail.employees, nil)
            }
            .store(in: &cancellables)
    }
    
    override func setUp() {
        super.setUp()
        sut = MockApiClient()
    }
    
    
    func test_mockJson_response() {
        let expectation = self.expectation(description: "EmployeeList")
        var employeeLists: [Employee]?
           var errorOutput : Error?
        getMockApiResponse { employees, error in
            employeeLists = employees
            errorOutput = error
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(employeeLists?.count, 11)
        XCTAssertEqual(employeeLists?[0].fullName, "Justine Mason - testing json")
       XCTAssertNil(errorOutput)
    }
    
    func test_thread_assignment() {
        let expectation = self.expectation(description: "EmployeeList")
        var currentThread: Bool = false
            var employeeLists: [Employee]?
        getMockApiResponse { employees, error in
            currentThread = Thread.isMainThread
            employeeLists = employees
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(currentThread, true)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
