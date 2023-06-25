//
//  macOS.swift
//  SlipboxProject
//
//  Created by Karin Prater on 24.11.22.
//

import SwiftUI

typealias UIImage = NSImage

extension Image {
    
    init(uiImage: UIImage) {
        self.init(nsImage: uiImage)
    }
}

typealias UIFont = NSFont
typealias UIPasteboard = NSPasteboard

extension NSPasteboard {
    
    func copyText(_ text: String) {
        self.clearContents()
        self.setString(text, forType: .string)
    }
}
