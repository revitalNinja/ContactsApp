//
//  ContentView.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contactsService = ContactsService()
    @StateObject private var viewModel = ContactsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if contactsService.permissionDenied {
                    PermissionView {
                        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsUrl)
                        }
                    }
                } else {
                    VStack {
                        SearchFieldView(text: $viewModel.searchText)
                        
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
                                    NavigationLink(destination: ContactDetailView(contact: contact)
                                        .environmentObject(viewModel)) {
                                        ContactRow(contact: contact)
                                            .environmentObject(viewModel)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Contacts")
            .task {
                await contactsService.loadContacts()
            }
            .onChange(of: contactsService.contacts) { _, newContacts in
                viewModel.updateContacts(newContacts)
            }
        }
    }
}

#Preview {
    ContentView()
}
