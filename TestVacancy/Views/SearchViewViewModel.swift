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
    
    @Published var searchText: String = ""
    
    var currentPage: Int = 0
    
    var vacancies: [Vacancy] = []
    
    var jobDetails: Vacancy?
    
    var suggests: [Suggestion] = []
    
    var onDataUpdate: (() -> Void)?
    
    var onDetailsUpdate: (() -> Void)?
    
    var onSuggestsUpdate: (() -> Void)?
    
    var cancellables: Set<AnyCancellable> = []
    
    func searchVacancy(text: String, page: Int, pagination: Bool) {
        networkService.makeVacancyRequest(text: text, page: page, pagination: pagination) { result in
            switch result {
            case .success(let vacancies):
                // Process the decoded data
                for vacancy in vacancies {
                    self.vacancies.append(Vacancy(id: vacancy.id, name: vacancy.name, salary: vacancy.salary, description: "", address: nil, employer: vacancy.employer, snippet: vacancy.snippet))
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

    func getSuggests(text: String) {
        suggests.removeAll()
        networkService.makeSuggestsRequest(text: text) { result in
            switch result {
            case .success(let suggests):
                // Process the decoded data
                for suggest in suggests {
                    self.suggests.append(Suggestion(text: suggest.text))
                    // append to array
                }
                self.onSuggestsUpdate?()
                //print("Received data: \(vacancies)")
            case .failure(let error):
                // Handle the error
                print("Error: \(error)")
            }
        }
    }
    
    func getDetails(id: String) {
        self.networkService.makeDetailsRequest(jobId: id) { result in
            switch result {
            case .success(let details):
                self.jobDetails = details
                self.onDetailsUpdate?()
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
