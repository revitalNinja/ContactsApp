//
//  InfoRowView.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 20)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(value)
                    .font(.body)
            }
            
            Spacer()
        }
    }
}

#Preview {
    InfoRow(icon: "phone.fill",
            title: "Phone",
            value: "+972-54-5895295")
        .padding()
}
