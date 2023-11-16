//
//  NetworkService.swift
//  TestVacancy
//
//  Created by Lukman Makhaev on 13.11.2023.
//

import Foundation

enum NetworkErroreType: Error {
    case emptyData
    case decodeError
    case messageError(message: String)
}

struct NetworkService {
    
    func makeVacancyRequest(text: String, page: Int, pagination: Bool, completion: @escaping (Result<[Vacancy], Error>) -> Void) {
        let url = "https://api.hh.ru/vacancies"
        var urlComponents = URLComponents(string: url)!
        
        var parameters = [
            "text": String(text)
        ]
        
        if pagination {
            parameters = [
                "text": String(text),
                "page": String(page)
            ]
        }
        
        // Add parameters to the URL
         urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            let error = NSError(domain: "YourApp", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                completion(.failure(error))
                return
            }

            // Check if there's data
            guard let data = data else {
                let error = NSError(domain: "YourApp", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            do {
                // Decode the JSON data into your Swift model
                let decodedData = try JSONDecoder().decode(Responce.self, from: data)
                let vacancies = decodedData.items
                completion(.success(vacancies ?? []))
            } catch {
                // Handle decoding errors
                completion(.failure(error))
            }
        }

        // Start the task
        task.resume()
    }
    
    func makeSuggestsRequest(text: String, completion: @escaping (Result<[Suggestion], Error>) -> Void) {
        let url = "https://api.hh.ru/suggests/vacancy_search_keyword"
        var urlComponents = URLComponents(string: url)!
        let parameters = [
            "text": String(text)
        ]
        
        // Add parameters to the URL
         urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            let error = NSError(domain: "YourApp", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                completion(.failure(error))
                return
            }

            // Check if there's data
            guard let data = data else {
                let error = NSError(domain: "YourApp", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            do {
                // Decode the JSON data into your Swift model
                let decodedData = try JSONDecoder().decode(Suggestions.self, from: data)
                let suggests = decodedData.items
                completion(.success(suggests ?? []))
            } catch {
                // Handle decoding errors
                completion(.failure(error))
            }
        }

        // Start the task
        task.resume()
    }
    
    func makeDetailsRequest(jobId: String, completion: @escaping (Result<Vacancy, Error>) -> Void) {
        let url = "https://api.hh.ru/vacancies/\(jobId)"
        
        // Add parameters to the URL
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            // Check for errors
            if let error = error {
                completion(.failure(error))
                return
            }

            // Check if there's data
            guard let data = data else {
                let error = NSError(domain: "YourApp", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            do {
                // Decode the JSON data into your Swift model
                let vacancy = try JSONDecoder().decode(Vacancy.self, from: data)
                completion(.success(vacancy))
            } catch {
                // Handle decoding errors
                completion(.failure(error))
            }
        }

        // Start the task
        task.resume()
    }
    
}
