//
//  EmployeeDirectoryViewModel.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation
import Combine

// protocol for the data here

protocol EmployeeListService {
    var employeesList: [Employee] {get set}
    var employeeOutputInjection: OutputEmployeeList? {get set}
    func getEmployeeListData()
}

protocol OutputEmployeeList: AnyObject {
    func didReceiveEmployeeListData(_ employeeViewModel: [LayoutStyleType]?, error: Error?)
}

final class EmployeeDirectoryListViewModel: EmployeeListService {
    
    private var cancellables: Set<AnyCancellable> = []
    var employeesList: [Employee] = []
    var employeeLists: [LayoutStyleType] = []
    weak var employeeOutputInjection: OutputEmployeeList?
    private let getApiService: APIServiceProtocol
    
    init(getApiService: APIServiceProtocol = APIClient()) {
        self.getApiService = getApiService
    }
    
    func getEmployeeListData() {
        getApiService.getEmployeeListRequest(apiEndPoint: EmployeeDirectoryEndPointsList.getEmployeeListWithDetails, responseModel: EmployeeListResponse.self)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("the error here is \(error.localizedDescription)")
                        self.employeeOutputInjection?.didReceiveEmployeeListData(nil, error: error)
                    }
                } receiveValue: { [weak self] employeeListDetail in
                    guard let self = self else { return }
                  
                    self.employeesList = employeeListDetail.employees
                    // this can also be used to get the events from the combine framework
                    // return as protocol objects
                    _ = employeeListDetail.employees.map {self.employeeLists.append(EmployeeSummaryLayout(employeePhotoLink: $0.photoURLSmall, employeeName: $0.fullName, employeeTeam: $0.team, employeeType: $0.employeeType.rawValue.lowercased().filter({$0 != "_"}), employeeBiography: $0.biography, id: $0.uuid, layOurRenderStyle: .employeeDetails))}
                    self.employeeOutputInjection?.didReceiveEmployeeListData(self.employeeLists, error: nil)
                    self.employeesList.removeAll()
                    self.employeeLists.removeAll()
                }
                .store(in: &cancellables)
    }
}



