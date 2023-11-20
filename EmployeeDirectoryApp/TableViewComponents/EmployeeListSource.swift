//
//  EmployeeListSource.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation
import UIKit

class EmployeeDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
        
    private lazy var imageService : ImageCacheService = ImageProcessingCache()
     var employeeList = [LayoutStyleType]()
    
    func updateEmployeeDetailList(_ list: [LayoutStyleType]) {
        self.employeeList = list
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employeDetailLayout = employeeList[indexPath.item]
        switch employeDetailLayout.layOurRenderStyle {
        case .employeeDetails :
            if let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCellId", for: indexPath) as? EmployeeDetailCell {
                if let layoutStyle = employeDetailLayout as? EmployeeSummaryLayoutType {
                    // u can configure cell here and return it
                    cell.configureEmployeeData(data: layoutStyle as! EmployeeSummaryLayout, imageService: imageService)
                    return cell
                }
            }
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                let sectionHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
                let sectionText = UILabel()
                sectionText.frame = CGRect.init(x: 5, y: 5, width: sectionHeader.frame.width, height: sectionHeader.frame.height)
                sectionText.text = "Employee Directory"
                sectionText.textAlignment = .center
                sectionText.font = .systemFont(ofSize: 14, weight: .bold) // my custom font
                sectionText.textColor = .black
                sectionHeader.addSubview(sectionText)
                return sectionHeader
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}



