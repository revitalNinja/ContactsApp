//
//  ErrorMessage.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI

struct ErrorMessageView: View {
    let retry: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Something went wrong")
                .font(.headline)
            
            Button("Try Again", action: retry)
                .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorMessageView {}
}
