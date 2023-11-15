//
//  VacancyTableViewCell.swift
//  TestVacancy
//
//  Created by Lukman Makhaev on 11.11.2023.
//

import Foundation
import UIKit
import Kingfisher

class VacancyTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    var vacancy: Vacancy? {
        didSet {
            guard let vacancyItem = vacancy else {return}
            if let imageUrl = URL(string: (vacancyItem.employer?.logoUrls?.the240) ?? "") {
                companyImageView.kf.setImage(with: imageUrl)
            }
            if let name = vacancyItem.name {
                vacancyNameLabel.text = name
            }
            if let salaryText = vacancyItem.salary?.fullSalaryString {
                salaryLabel.text = salaryText
            }
            if let companyName = vacancyItem.employer?.name {
                companyNameLabel.text = companyName
            }
            if let requirements = vacancyItem.snippet?.requirement {
                requirementsLabel.text = requirements
            }
            if let responsibility = vacancyItem.snippet?.responsibility {
                responsibilitiesLabel.text = responsibility
            }
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let vacancyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "IOS Developer"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let salaryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Yandex"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let requirementsLabel: UILabel = {
        let label = UILabel()
        label.text = "Требования работодателей к работникам"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let responsibilitiesLabel: UILabel = {
        let label = UILabel()
        label.text = "Объязанности работника"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyImageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 50
        img.layer.borderWidth = 1.0 //Or some other value
        img.layer.borderColor = UIColor(hexString: "e7e7e7").cgColor
        img.clipsToBounds = true
        return img
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        //self.contentView.addSubview(companyImageView)
        containerView.addSubview(vacancyNameLabel)
        containerView.addSubview(salaryLabel)
        containerView.addSubview(companyNameLabel)
        containerView.addSubview(companyImageView)
        containerView.addSubview(requirementsLabel)
        containerView.addSubview(responsibilitiesLabel)
        
        self.contentView.addSubview(containerView)
    
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true;
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true;
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true;
        containerView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        companyImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10).isActive = true
        companyImageView.trailingAnchor.constraint(equalTo: self.salaryLabel.trailingAnchor, constant: -10).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        vacancyNameLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10).isActive = true
        vacancyNameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        vacancyNameLabel.trailingAnchor.constraint(equalTo: self.companyImageView.leadingAnchor, constant: -10).isActive = true
        
        salaryLabel.topAnchor.constraint(equalTo: self.vacancyNameLabel.bottomAnchor).isActive = true
        salaryLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        salaryLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        companyNameLabel.topAnchor.constraint(equalTo: self.salaryLabel.bottomAnchor).isActive = true
        companyNameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        companyNameLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        requirementsLabel.topAnchor.constraint(equalTo: self.companyNameLabel.bottomAnchor, constant: 12).isActive = true
        requirementsLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        requirementsLabel.trailingAnchor.constraint(equalTo: companyImageView.leadingAnchor, constant: -10).isActive = true
        
        responsibilitiesLabel.topAnchor.constraint(equalTo: self.requirementsLabel.bottomAnchor, constant: 5).isActive = true
        responsibilitiesLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        responsibilitiesLabel.trailingAnchor.constraint(equalTo: companyImageView.leadingAnchor, constant: -10).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

#Preview {
    let cell = VacancyTableViewCell()
    return cell
}
