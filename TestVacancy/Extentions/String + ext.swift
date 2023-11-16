//
//  String + ext.swift
//  TestVacancy
//
//  Created by Lukman Makhaev on 16.11.2023.
//

import Foundation
import UIKit

extension String {
    func attributedStringFromHTML(withFont font: UIFont) -> NSAttributedString? {
            do {
                // Convert HTML to NSData
                let data = self.data(using: .utf8)

                // Create an NSAttributedString from HTML data
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]

                let attributes: [NSAttributedString.Key: Any] = [
                    .font: font
                ]

                let attributedString = try NSMutableAttributedString(
                    data: data!,
                    options: options,
                    documentAttributes: nil
                )

                // Apply the specified font to the entire string
                attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))

                return attributedString
            } catch {
                print("Error converting HTML to attributed string: \(error)")
                return nil
            }
        }
}
