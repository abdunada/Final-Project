//
//  UIImage&StringURLToImage.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 25/04/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageFromStringURL(stringURL: String) {
       
        if let url = URL(string: stringURL) {
            if let imageData = try? Data(contentsOf: url) {
                self.image = UIImage(data: imageData)
            }
        }
    }
    
    func makeCircularImage() {
        self.layer.cornerRadius = self.frame.width / 2
    }
}
