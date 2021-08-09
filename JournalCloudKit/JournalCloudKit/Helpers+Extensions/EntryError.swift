//
//  EntryError.swift
//  JournalCloudKit
//
//  Created by Bryan Gomez on 8/9/21.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String? {
        switch self {
        
        case .ckError(let error):
            return error.localizedDescription
        case .couldNotUnwrap:
            return "Unable to get this Hype"
        }
    }
}
