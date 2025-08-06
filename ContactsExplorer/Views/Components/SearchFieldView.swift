//
//  SearchFieldView.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search name or phone...", text: $text)
            
            if !text.isEmpty {
                Button("Clear") { text = "" }
                    .font(.caption)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var text = ""
    return SearchFieldView(text: $text)
}
