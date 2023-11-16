//
//  VacanciesTableView.swift
//  TestVacancy
//
//  Created by Lukman Makhaev on 16.11.2023.
//

import Foundation
import UIKit

class VacanciesTableViewController: UITableViewController {
    var viewModel = SearchViewViewModel()
    var detailsViewController = VacancyDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(hexString: "eeeeee")
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        tableView.register(VacancyTableViewCell.self, forCellReuseIdentifier: "vacancyTableViewCell")
    }
}

// MARK: TABLEVIEW FUNCTIONS
extension VacanciesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.vacancies.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vacancyTableViewCell", for: indexPath) as! VacancyTableViewCell
        cell.vacancy = viewModel.vacancies[indexPath.row]
        
        let verticalPadding: CGFloat = 8
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 8, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
        
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.vacancies.count - 5 {
            print(indexPath)
            viewModel.currentPage += 1
            viewModel.searchVacancy(text: viewModel.searchText, page: viewModel.currentPage, pagination: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        tableView.deselectRow(at: didSelectRowAt, animated: true)
        
        self.viewModel.getDetails(id: self.viewModel.vacancies[didSelectRowAt.row].id!)
        viewModel.onDetailsUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.detailsViewController.vacancy = self?.viewModel.jobDetails
                //self?.present(self!.detailsViewController, animated: true, completion: nil)
                
                if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                    rootViewController.present(self!.detailsViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

#Preview {
    let controller = VacanciesTableViewController()
    return controller
}
