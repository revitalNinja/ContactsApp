//
//  PermissionView.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI

struct PermissionView: View {
    let requestAccess: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Contacts Access Needed")
                .font(.title2)
                .bold()
            
            Text("Please grant access to view your contacts")
                .multilineTextAlignment(.center)
            
            Button(action: requestAccess) {
                Text("Allow Access")
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
    }
}

#Preview {
    PermissionView {}
}
