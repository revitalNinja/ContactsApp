//
//  Image+Extention.swift
//  ContactsExplorer
//
//  Created by Revital Pisman on 06/08/2025.
//

import SwiftUI
import UIKit

extension Image {
    init?(data: Data?) {
        guard let data = data,
              let uiImage = UIImage(data: data) else {
            return nil
        }
        self = Image(uiImage: uiImage)
    }
}
