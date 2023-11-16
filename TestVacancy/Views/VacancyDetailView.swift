//
//  VacancyDetailView.swift
//  TestVacancy
//
//  Created by Lukman Makhaev on 16.11.2023.
//

import Foundation
import UIKit

class VacancyDetailView: UIViewController {
    
    var vacancy: Vacancy? {
        didSet {
            guard let vacancyItem = vacancy else {return}
            if let name = vacancyItem.name {
                titleLabel.text = name
            }
            if let salary = vacancyItem.salary?.fullSalaryString {
                salaryLabel.text = salary
            }
            if let description = vacancyItem.description {
                let attributed = description.attributedStringFromHTML(withFont: UIFont.systemFont(ofSize: 18))
                
                descriptionLabel.attributedText = attributed
            }
            if let address = vacancyItem.address?.raw {
                addressLabel.text = "Адрес: \(address)"
            }
        }
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let salaryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        stackViewUI()
        
    }
    
    func setupUI() {
        view.backgroundColor = .white
        title = "Подробности"
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        salaryLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        addressLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
    }
    
    func stackViewUI() {
        // Add UI components to the stack view
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(salaryLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(addressLabel)
  
    }
}

#Preview {
    let controller = VacancyDetailView()
    return controller
}
