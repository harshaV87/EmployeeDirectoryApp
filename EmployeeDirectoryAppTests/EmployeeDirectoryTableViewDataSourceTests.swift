//
//  EmployeeDirectoryTableViewDataSourceTests.swift
//  EmployeeDirectoryAppTests
//
//  Created by harsha BV on 9/20/23.
//

import Foundation
import XCTest
@testable import EmployeeDirectoryApp

final class tableViewSourceTests: XCTestCase {
    private var sut: EmployeeDataSource!
    
    override func setUp() {
        super.setUp()
        sut = EmployeeDataSource()
    }
    
    override func tearDown() {
         super.tearDown()
        sut = nil 
    }
    
    func test_NumberOfRows_EmptyList() {
        sut.updateEmployeeDetailList([])
        sut.employeeList = []
        let noOfRowsInSection = sut.tableView(.init(), numberOfRowsInSection: 4)
        XCTAssertEqual(noOfRowsInSection, 0)
    }
    
    func test_NumberOfRows_WithList() {
        let sut = EmployeeDataSource()
        let layout = EmployeeSummaryLayout(employeePhotoLink: "Picture", employeeName: "", employeeTeam: "Name", employeeType: "Type", employeeBiography: "Biography", id: "id", layOurRenderStyle: .employeeDetails)
        sut.updateEmployeeDetailList([layout])
        let noOfRowsInSection = sut.tableView(.init(), numberOfRowsInSection: 4)
        XCTAssertEqual(noOfRowsInSection, 1)
        
    }
    
    func test_cell_types() {
        let sut = EmployeeDataSource()
        let layout = EmployeeSummaryLayout(employeePhotoLink: "Picture", employeeName: "", employeeTeam: "Name", employeeType: "Type", employeeBiography: "Biography", id: "id", layOurRenderStyle: .employeeDetails)
        sut.updateEmployeeDetailList([layout])
        let tableView = UITableView()
        tableView.register(EmployeeDetailCell.self, forCellReuseIdentifier: "employeeCellId")
        let cellAtIndexo = sut.tableView(tableView, cellForRowAt: .init(row: 0, section: 1))
       
        XCTAssertTrue(cellAtIndexo is EmployeeDetailCell)
    }
}
