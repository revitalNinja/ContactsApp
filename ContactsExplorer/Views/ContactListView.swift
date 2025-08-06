//
//  ContactListView.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI

struct ContactsListView: View {
    @EnvironmentObject var viewModel: ContactsViewModel
    @EnvironmentObject var contactsService: ContactsService
    
    var body: some View {
        Group {
            if contactsService.isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if contactsService.error != nil {
                ErrorMessageView {
                    Task { await contactsService.loadContacts() }
                }
            } else if viewModel.filteredContacts.isEmpty && !viewModel.searchText.isEmpty {
                NoResultsView()
            } else {
                List(viewModel.filteredContacts) { contact in
                    ContactRow(contact: contact)
                }
            }
        }
    }
}

#Preview {
    let contactsService = ContactsService()
    let viewModel = ContactsViewModel()
    
    viewModel.updateContacts([
        Contact(id: "1",
                name: "John Doe",
                phoneNumber: "+1-555-123",
                email: "john@test.com",
                imageData: nil),
        
        Contact(id: "2",
                name: "Jane Smith",
                phoneNumber: "+1-555-456",
                email: "jane@test.com",
                imageData: nil)
    ])
    
    return NavigationStack {
        ContactsListView()
            .environmentObject(viewModel)
            .environmentObject(contactsService)
    }
}
