//
//  ContactRowView.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI

struct ContactRow: View {
    @EnvironmentObject var viewModel: ContactsViewModel
    let contact: Contact
    
    var body: some View {
        HStack {
            ContactAvatarView(contact: contact, size: 50)
            contactInfo
            Spacer()
            favoriteButton
        }
        .padding(.vertical, 4)
        .background(NavigationLink("", destination: ContactDetailView(contact: contact)).opacity(0))
    }
    
    var contactInfo: some View {
        VStack(alignment: .leading) {
            Text(contact.name)
                .font(.headline)
            
            if !contact.phoneNumber.isEmpty {
                Text(contact.phoneNumber)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
    
    var favoriteButton: some View {
        Button {
            viewModel.toggleFavorite(contact)
        } label: {
            Image(systemName: viewModel.isFavorite(contact) ? "star.fill" : "star")
                .foregroundColor(viewModel.isFavorite(contact) ? .yellow : .gray)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

#Preview {
    ContactRow(contact: Contact(id: "1",
                                name: "Revital Pisman",
                                phoneNumber: "+972-54-5895295",
                                email: "revital.pisman@gmail.com", imageData: nil))
        .environmentObject(ContactsViewModel())
        .padding()
}
