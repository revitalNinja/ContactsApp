//
//  FavoritesService.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import Foundation

@MainActor
class FavoritesService: ObservableObject {
    @Published private(set) var favoriteContactIds: Set<String> = []
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "favoriteContacts"
    
    init() {
        loadFavorites()
    }
    
    func toggleFavorite(contactId: String) {
        if favoriteContactIds.contains(contactId) {
            favoriteContactIds.remove(contactId)
        } else {
            favoriteContactIds.insert(contactId)
        }
        saveFavorites()
    }
    
    func isFavorite(contactId: String) -> Bool {
        favoriteContactIds.contains(contactId)
    }
}

private extension FavoritesService {
    
    private func loadFavorites() {
        if let data = userDefaults.data(forKey: favoritesKey),
           let favorites = try? JSONDecoder().decode(Set<String>.self, from: data) {
            favoriteContactIds = favorites
        }
    }
    
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteContactIds) {
            userDefaults.set(data, forKey: favoritesKey)
        }
    }
}
