//
//  ViewController.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/19/23.
//

import UIKit

class ViewController: UIViewController {
        
    private lazy var employeeViewModel : EmployeeListService = EmployeeDirectoryListViewModel()
    private lazy var employeeDataSource : EmployeeDataSource = EmployeeDataSource()
    private lazy var refreshControlService: RefreshControlService = UIRefreshControls()
    
    //UI
    private let employeeListTableView: UITableView = {
    let employeeDirectoryTableView = UITableView()
    employeeDirectoryTableView.backgroundColor = UIColor.white
    employeeDirectoryTableView.translatesAutoresizingMaskIntoConstraints = false
     return employeeDirectoryTableView }()
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewModel()
        configureRefreshService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.startAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
    }
    
    private func configureRefreshService() {
        refreshControlService.configureRefreshControl(tableView: employeeListTableView)
        refreshControlService.configureAttributes()
        refreshControlService.callBackActionForRefresh = { [weak self] in
        self?.employeeViewModel.getEmployeeListData()
        }
    }
    
    private func configureViewModel() {
        employeeViewModel.getEmployeeListData()
        employeeViewModel.employeeOutputInjection = self
    }
    
    private func configureTableView() {
        employeeListTableView.register(EmployeeDetailCell.self, forCellReuseIdentifier: "employeeCellId")
        view.addSubview(employeeListTableView)
        NSLayoutConstraint.activate([
            employeeListTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 4),
            employeeListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -4),
            employeeListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            employeeListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
        employeeListTableView.dataSource = employeeDataSource
        employeeListTableView.delegate = employeeDataSource
    }
}

extension ViewController: OutputEmployeeList {
    func didReceiveEmployeeListData(_ employeeViewModel: [LayoutStyleType]?, error: Error?) {
        self.view.stopAnimating()
        if let employeeViewModel = employeeViewModel {
            if employeeViewModel.count > 0 {
                self.employeeDataSource.updateEmployeeDetailList(employeeViewModel)
                self.employeeListTableView.reloadData()
            } else {
                // Empty list
                showAlertMessage(alertText: "Sorry", alertMessage: "No results")
            }
        } else {
            // no data here
            if error != nil {
               showAlertMessage(alertText: "Error", alertMessage: "Please try again")
            }
        }
    }
}







