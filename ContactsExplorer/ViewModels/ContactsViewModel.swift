//
//  ContactsViewModel.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import Foundation

@MainActor
class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var searchText = ""
    @Published var favoriteIds: Set<String> = []
    
    var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return contacts
        } else {
            let search = searchText.lowercased()
            return contacts.filter { contact in
                contact.name.lowercased().contains(search) ||
                contact.phoneNumber.contains(searchText)
            }
        }
    }
    
    init() {
        loadFavorites()
    }
    
    func updateContacts(_ newContacts: [Contact]) {
        contacts = newContacts
    }
    
    func toggleFavorite(_ contact: Contact) {
        if favoriteIds.contains(contact.id) {
            favoriteIds.remove(contact.id)
        } else {
            favoriteIds.insert(contact.id)
        }
        saveFavorites()
    }
    
    func isFavorite(_ contact: Contact) -> Bool {
        favoriteIds.contains(contact.id)
    }
}

private extension ContactsViewModel {
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let ids = try? JSONDecoder().decode(Set<String>.self, from: data) {
            favoriteIds = ids
        }
    }
    
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteIds) {
            UserDefaults.standard.set(data, forKey: "favorites")
        }
    }
}
