//
//  ContactDetailView.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI

struct ContactDetailView: View {
    @EnvironmentObject var viewModel: ContactsViewModel
    let contact: Contact
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                header
                contactInfo
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                favoriteButton
            }
        }
    }
    
    private var header: some View {
        VStack {
            ContactAvatarView(contact: contact, size: 120)
            
            Text(contact.name)
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
    
    private var contactInfo: some View {
        VStack(alignment: .leading, spacing: 15) {
            if !contact.phoneNumber.isEmpty {
                InfoRow(icon: "phone.fill", title: "Phone", value: contact.phoneNumber)
            }
            
            if !contact.email.isEmpty {
                InfoRow(icon: "envelope.fill", title: "Email", value: contact.email)
            }
        }
        .padding()
    }
    
    private var favoriteButton: some View {
        Button {
            viewModel.toggleFavorite(contact)
        } label: {
            Image(systemName: viewModel.isFavorite(contact) ? "star.fill" : "star")
                .foregroundColor(viewModel.isFavorite(contact) ? .yellow : .blue)
        }
    }
}

#Preview {
    NavigationStack {
        ContactDetailView(contact: Contact(id: "1",
                                           name: "Revital Pisman",
                                           phoneNumber: "+972-54-5895292",
                                           email: "revital.pisman@gmail.com",
                                           imageData: nil))
            .environmentObject(ContactsViewModel())
    }
}
