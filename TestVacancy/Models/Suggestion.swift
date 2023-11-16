//
//  Suggestion.swift
//  TestVacancy
//
//  Created by Lukman Makhaev on 16.11.2023.
//

import Foundation
// MARK: - Responce
class Suggestions: Codable {
    let items: [Suggestion]?

    init(items: [Suggestion]?) {
        self.items = items
    }
}

// MARK: - Suggestion
class Suggestion: Codable {
    let text: String?

    init(text: String?) {
        self.text = text
    }
}
