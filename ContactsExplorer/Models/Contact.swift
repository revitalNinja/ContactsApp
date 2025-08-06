//
//  Contact.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import Foundation

struct Contact: Identifiable, Hashable {
    let id: String
    let name: String
    let phoneNumber: String
    let email: String
    let imageData: Data?
}
