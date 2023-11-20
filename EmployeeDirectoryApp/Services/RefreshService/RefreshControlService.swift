//
//  RefreshControlService.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation
import UIKit

@MainActor
protocol RefreshControlService {
    var callBackActionForRefresh : (() -> ())? {get set}
    func configureRefreshControl(tableView: UITableView)
    func configureAttributes()
}


@MainActor
class UIRefreshControls: UIControl, RefreshControlService {

    var refreshControl = UIRefreshControl()
    var callBackActionForRefresh : (() -> ())?
    
    func configureRefreshControl(tableView: UITableView) {
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        callBackActionForRefresh?()
        refreshControl.endRefreshing()
    }
    
    func configureAttributes() {
        refreshControl.tintColor = .red
        refreshControl.attributedTitle = NSAttributedString(string: "Updating the list, Please wait")
    }
}
