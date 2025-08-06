//
//  AvatarView.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI

struct ContactAvatarView: View {
    let contact: Contact
    let size: CGFloat
    
    var body: some View {
        Group {
            if let imageData = contact.imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Circle()
                    .fill(.gray.gradient)
                    .overlay {
                        Text(initials)
                            .font(.title)
                            .foregroundColor(.white)
                    }
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
    
    private var initials: String {
        let words = contact.name.split(separator: " ")
        let first = words.first?.first?.uppercased() ?? ""
        let last = words.count > 1 ? String(words.last?.first?.uppercased() ?? "") : ""
        return first + last
    }
}

#Preview {
    ContactAvatarView(contact: Contact(id: "1",
                                       name: "Revital Pisman",
                                       phoneNumber: "",
                                       email: "",
                                       imageData: nil),
                      size: 80)
}
