//
//  LayoutStyles.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation


enum LayoutStyle {
    case employeeDetails
    // here we can add more enus if we have say server driven UI
}

protocol LayoutStyleType {

    var id: String {get}
    var layOurRenderStyle: LayoutStyle {get}
}

protocol EmployeeSummaryLayoutType : LayoutStyleType {
    // summary
    // photo
    var employeePhotoLink: String {get}
    // name
    var employeeName: String {get}
    // team
    var employeeTeam: String {get}
    // employeeType
    var employeeType: String {get}
    // bioraphy
    var employeeBiography: String {get}
}
