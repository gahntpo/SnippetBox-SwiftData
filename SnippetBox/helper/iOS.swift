//
//  iOS.swift
//  SlipboxProject
//
//  Created by Karin Prater on 09.02.23.
//

import UIKit

extension UIPasteboard {
    
    func copyText(_ text: String) {
        self.string = text
    }
}
