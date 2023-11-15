//
//  ViewController.swift
//  TestVacancy
//
//  Created by Lukman Makhaev on 11.11.2023.
//

import UIKit
import Combine

class SearchView: UIViewController {
    
    // MARK: Properties
    var searchBar: UISearchBar = {
        var sb = UISearchBar()
        sb.backgroundColor = UIColor(hexString: "eeeeee")
        sb.placeholder = "Поиск"
        sb.searchBarStyle = .prominent
        return sb
    }()
    
    var viewModel = SearchViewViewModel()
    
    let tableView: UITableView = {
        var tw = UITableView()
        tw.backgroundColor = UIColor(hexString: "eeeeee")
        tw.showsVerticalScrollIndicator = false
        tw.clipsToBounds = true
        return tw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.dismissKeyboard()
        
        
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        
        DispatchQueue.main.async {
            self.viewModel.searchVacancy(text: "", page: 0)
        }
        
        viewModel.onDataUpdate = { [weak self] in
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
                    print("searching...")
                    self?.viewModel.currentPage = 0
                    self?.viewModel.vacancies.removeAll()
                    self?.viewModel.searchVacancy(text: searchText, page: 0)
                }
            }
            .store(in: &viewModel.cancellables)
        
        tableView.register(VacancyTableViewCell.self, forCellReuseIdentifier: "vacancyTableViewCell")
        initViews()
        
    }
    
    func initViews() {
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
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
        return viewModel.vacancies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.vacancies.count - 5 {
            print(indexPath)
            viewModel.currentPage += 1
            viewModel.nextPage(text: searchBar.text!, page: viewModel.currentPage)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        tableView.deselectRow(at: didSelectRowAt, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: SEARCHBAR FUNCTIONS
extension SearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print("searchText \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.searchVacancy(text: searchBar.text!, page: 0)
        //print("searchText \(searchBar.text)")
    }
}

#Preview {
    let controller = SearchView()
    return controller
}
