//
//  EmployeeSummaryLayout.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation

class EmployeeSummaryLayout: EmployeeSummaryLayoutType {
    
    var employeePhotoLink: String
    var employeeName: String
    var employeeTeam: String
    var employeeType: String
    var employeeBiography: String
    var id: String
    var layOurRenderStyle: LayoutStyle
    
    init(employeePhotoLink: String, employeeName: String, employeeTeam: String, employeeType: String, employeeBiography: String,id: String, layOurRenderStyle: LayoutStyle) {
    self.employeePhotoLink = employeePhotoLink
    self.employeeName = employeeName
    self.employeeTeam = employeeTeam
    self.employeeType = employeeType
    self.employeeBiography = employeeBiography
    self.id = id
    self.layOurRenderStyle = layOurRenderStyle
    }
}

