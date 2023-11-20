//
//  EmployeeDirectoryViewModelDelegateTests.swift
//  EmployeeDirectoryAppTests
//
//  Created by harsha BV on 9/20/23.
//


import Foundation
import XCTest
@testable import EmployeeDirectoryApp


class EmployeeModelOutputTests: XCTestCase, OutputEmployeeList {
    
    var sut: MockEmployeeViewModel!
    
    var expectation: XCTestExpectation?
    var outPutData : [LayoutStyleType]?
    
    override func setUp() {
        super.setUp()
        sut = MockEmployeeViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testDelegateOutput() {
        sut.employeeOutputInjection = self
        expectation = expectation(description: "Data Output")
        sut.getEmployeeListData()
        waitForExpectations(timeout: 1.0, handler: nil)
        let result = try? XCTUnwrap(outPutData)
        XCTAssertEqual(result?.count, 1)
    }
    
    func didReceiveEmployeeListData(_ employeeViewModel: [LayoutStyleType]?, error: Error?) {
        self.outPutData = employeeViewModel
        expectation?.fulfill()
        expectation = nil
    }
}


class MockEmployeeViewModel : EmployeeListService {
    var employeesList: [Employee] = []
    var employeeOutputInjection: OutputEmployeeList?
    
    func getEmployeeListData() {
        let employeeInfoLayout = EmployeeSummaryLayout(employeePhotoLink: "photolink", employeeName: "", employeeTeam: "", employeeType: "", employeeBiography: "", id: "", layOurRenderStyle: .employeeDetails)
        employeeOutputInjection?.didReceiveEmployeeListData([employeeInfoLayout], error: nil)
    }

}
