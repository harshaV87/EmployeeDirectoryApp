//
//  EmpoyeeDetailTableViewCell.swift
//  EmployeeDirectoryApp
//
//  Created by harsha BV on 9/20/23.
//

import Foundation
import UIKit

class EmployeeDetailCell: UITableViewCell {
    
    
    // UI
    private func commonInit() {
            contentView.addSubview(containerView)
            containerView.addSubview(employeeProfileImageView)
            containerView.addSubview(completeDetailStackView)
            NSLayoutConstraint.activate(staticConstraints())
        }
    
    private lazy var completeDetailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            employeeNameLabel, employeeTypeLabel, employeeTeamLabel, employeeBiographyLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
      }()
    
    private let employeeProfileImageView: UIImageView = {
            let profileImgage = UIImageView()
        profileImgage.contentMode = .scaleAspectFit
        profileImgage.translatesAutoresizingMaskIntoConstraints = false
        profileImgage.clipsToBounds = true
            return profileImgage
        }()
    
    private let containerView: UIView = {
            // wrapper to contain all the subviews for the UITableViewCell
            let view = UIView()
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.black.cgColor
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
    private let employeeNameLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.numberOfLines = 0
            label.textColor = .black
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    private let employeeBiographyLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.textColor =  .darkGray
            label.numberOfLines = 0
            label.clipsToBounds = true
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    private let employeeTeamLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.textColor =  .darkGray
            label.clipsToBounds = true
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    private let employeeTypeLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.textColor =  .darkGray
            label.clipsToBounds = true
        label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    private func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
            // constraints - Programmatic
        constraints.append(contentsOf: [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        constraints.append(contentsOf: [
            employeeProfileImageView.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 5.0),
            employeeProfileImageView.heightAnchor.constraint(equalToConstant: 118.0),
            employeeProfileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            employeeProfileImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        constraints.append(contentsOf: [
            completeDetailStackView.topAnchor.constraint(equalTo: employeeProfileImageView.bottomAnchor, constant:4.0),
            completeDetailStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4.0),
            completeDetailStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            completeDetailStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        return constraints
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
         commonInit()
    }
    
    func configureEmployeeData(data: EmployeeSummaryLayout, imageService: ImageCacheService) {
//      // for the sake of simplicity, no localization is implemented
        employeeNameLabel.text = "Name: \(data.employeeName)"
        employeeTypeLabel.text = "Job: \(data.employeeType)"
        employeeTeamLabel.text = "Team: \(data.employeeTeam)"
        employeeBiographyLabel.text = "Biography: \(data.employeeBiography)"
        employeeProfileImageView.image = imageService.placeHolderTempImage
        // Image retrieval
        imageService.load(url: data.employeePhotoLink, employeeSummaryItem: data) { [weak self] employeeInfo, employeeImage in
            if employeeInfo.employeePhotoLink == data.employeePhotoLink {
                // prevent flickering on large image set
                DispatchQueue.main.async {
                    self?.employeeProfileImageView.image = employeeImage
                }
            } else {
                self?.employeeProfileImageView.image = imageService.placeHolderTempImage
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}


 

