//
//  ContactsError.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import Foundation

enum ContactsError: Error, LocalizedError {
    case accessDenied
    case noContacts
    case fetchFailed
    
    var errorDescription: String? {
        switch self {
        case .accessDenied:
            return "Contacts access denied"
        case .noContacts:
            return "No contacts found"
        case .fetchFailed:
            return "Failed to fetch contacts"
        }
    }
}
