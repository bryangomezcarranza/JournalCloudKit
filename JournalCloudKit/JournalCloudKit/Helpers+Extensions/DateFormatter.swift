//
//  DateFormatter.swift
//  JournalCloudKit
//
//  Created by Bryan Gomez on 8/9/21.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
