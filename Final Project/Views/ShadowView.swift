//
//  ShadowView.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 26/04/2022.
//

import UIKit

class ShadowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpShadowFrame()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpShadowFrame()
    }
    
    func setUpShadowFrame() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.cornerRadius = 15
    }

}
