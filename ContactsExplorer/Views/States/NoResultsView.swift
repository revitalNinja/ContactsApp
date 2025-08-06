//
//  NoResultsView.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI

struct NoResultsView: View {
    var body: some View {
        Text("No contacts found")
            .font(.headline)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NoResultsView()
}
