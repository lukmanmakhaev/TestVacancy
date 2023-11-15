//
//  NetworkService.swift
//  TestVacancy
//
//  Created by Lukman Makhaev on 13.11.2023.
//

import Foundation
import Alamofire

enum NetworkErroreType: Error {
    case emptyData
    case decodeError
    case messageError(message: String)
}

struct NetworkService {
    
    func makeURLRequest(text: String, page: Int, completion: @escaping (Result<[Vacancy], Error>) -> Void) {
        let url = "https://api.hh.ru/vacancies"
        var urlComponents = URLComponents(string: url)!
        let parameters = [
            "text": String(text),
            "page": String(page)
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
}
