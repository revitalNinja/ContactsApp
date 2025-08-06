//
//  ContactsService.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import Foundation
import Contacts

@MainActor
class ContactsService: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var permissionDenied = false
    
    private let store = CNContactStore()
    
    func loadContacts() async {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        if status == .denied || status == .restricted {
            permissionDenied = true
            return
        }
        
        if status == .notDetermined {
            await requestPermission()
            return
        }
        
        await fetchContacts()
    }
    
    func requestPermission() async {
        do {
            let granted = try await store.requestAccess(for: .contacts)
            if granted {
                permissionDenied = false
                await fetchContacts()
            } else {
                permissionDenied = true
            }
        } catch {
            self.error = error
        }
    }
}

private extension ContactsService {
    
    private func fetchContacts() async {
        isLoading = true
        error = nil
        
        let keys = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactImageDataKey
        ] as [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            let fetchedContacts = try await Task.detached(priority: .userInitiated) { [weak self] () -> [Contact] in
                guard let self = self else { return [] }
                
                var results: [Contact] = []
                try await store.enumerateContacts(with: request) { cnContact, _ in
                    let contact = Contact(
                        id: cnContact.identifier,
                        name: "\(cnContact.givenName) \(cnContact.familyName)".trimmingCharacters(in: .whitespaces),
                        phoneNumber: cnContact.phoneNumbers.first?.value.stringValue ?? "",
                        email: cnContact.emailAddresses.first?.value as String? ?? "",
                        imageData: cnContact.imageData
                    )
                    results.append(contact)
                }
                return results
            }.value
            
            await MainActor.run {
                contacts = fetchedContacts.sorted { $0.name < $1.name }
            }
        } catch {
            await MainActor.run {
                self.error = error
            }
        }
        
        isLoading = false
    }
}
