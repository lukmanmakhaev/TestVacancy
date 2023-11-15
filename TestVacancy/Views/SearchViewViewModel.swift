//
//  SearchViewViewModel.swift
//  TestVacancy
//
//  Created by Lukman Makhaev on 11.11.2023.
//

import Foundation
import Combine

class SearchViewViewModel {
    var networkService = NetworkService()
    
    @Published var searchField: String = ""
    
    var currentPage: Int = 0
    
    var vacancies: [Vacancy] = []
    
    var onDataUpdate: (() -> Void)?
    
    var cancellables: Set<AnyCancellable> = []
    
    func searchVacancy(text: String, page: Int) {
        networkService.makeURLRequest(text: text, page: page) { result in
            switch result {
            case .success(let vacancies):
                // Process the decoded data
                for vacancy in vacancies {
                    self.vacancies.append(Vacancy(id: vacancy.id, name: vacancy.name, salary: vacancy.salary, employer: vacancy.employer, snippet: vacancy.snippet))
                    // append to array
                }
                self.onDataUpdate?()
                //print("Received data: \(vacancies)")
            case .failure(let error):
                // Handle the error
                print("Error: \(error)")
            }
        }
    }
    
    func nextPage(text: String, page: Int) {
        networkService.makeURLRequest(text: text, page: page) { result in
            switch result {
            case .success(let vacancies):
                // Process the decoded data
                for vacancy in vacancies {
                    self.vacancies.append(Vacancy(id: vacancy.id, name: vacancy.name, salary: vacancy.salary, employer: vacancy.employer, snippet: vacancy.snippet))
                    // append to array
                }
                self.onDataUpdate?()
                //print("Received data: \(vacancies)")
            case .failure(let error):
                // Handle the error
                print("Error: \(error)")
            }
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
}
