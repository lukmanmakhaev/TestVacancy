//
//  ViewController.swift
//  TestVacancy
//
//  Created by Lukman Makhaev on 11.11.2023.
//

import UIKit
import Combine

class SearchView: UIViewController {
    
    var viewModel = SearchViewViewModel()
    var vacanciesVC = VacanciesList()
    
    // MARK: Properties
    var searchBar: UISearchBar = {
        var sb = UISearchBar()
        sb.backgroundColor = UIColor(hexString: "eeeeee")
        sb.placeholder = "Поиск"
        sb.searchBarStyle = .prominent
        return sb
    }()
    
    let tableView: UITableView = {
        var tw = UITableView()
        tw.backgroundColor = .clear
        tw.showsVerticalScrollIndicator = false
        tw.clipsToBounds = true
        return tw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.dismissKeyboard()
        
        vacanciesVC.viewModel = viewModel
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.onSuggestsUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // Combine Publishers
        NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
            .map { ($0.object as? UISearchTextField)?.text ?? "" }
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                if searchText.count >= 3 {
                    self?.viewModel.currentPage = 0
                    self?.viewModel.getSuggests(text: searchText)
                } else {
                    self?.viewModel.suggests.removeAll()
                    self?.vacanciesVC.tableView.reloadData()
                    self?.tableView.reloadData()
                }
            }
            .store(in: &viewModel.cancellables)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "suggestsCell")
        initViews()
    }
    
    func initViews() {
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(vacanciesVC.tableView)
        vacanciesVC.tableView.translatesAutoresizingMaskIntoConstraints = false
        vacanciesVC.tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        vacanciesVC.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vacanciesVC.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        vacanciesVC.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}

// MARK: TABLEVIEW FUNCTIONS
extension SearchView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBar.text == "" ? 1 : viewModel.suggests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "suggestsCell", for: indexPath)
        
        if searchBar.text == "" {
            cell.textLabel?.text = "Введите в поиск название и появится список вакансий"
        } else {
            cell.textLabel?.text =  viewModel.suggests[indexPath.row].text
        }
        cell.textLabel?.numberOfLines = 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        tableView.deselectRow(at: didSelectRowAt, animated: true)
        
        searchBar.text = viewModel.suggests[didSelectRowAt.row].text
        self.viewModel.vacancies.removeAll()
        self.viewModel.searchVacancy(text: self.searchBar.text ?? "", page: 0, pagination: false)
        tableView.isHidden = true
        self.vacanciesVC.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Show the table view when the user begins editing the search bar
        tableView.isHidden = false
    }
}

// MARK: SEARCHBAR FUNCTIONS
extension SearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print("searchText \(searchText)")
        viewModel.searchText = searchText
        //viewModel.getSuggests(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.vacancies.removeAll()
        self.viewModel.searchVacancy(text: searchBar.text!, page: 0, pagination: false)
        vacanciesVC.tableView.reloadData()
        tableView.isHidden = true
        searchBar.resignFirstResponder()
    }
}

#Preview {
    let controller = SearchView()
    return controller
}
