//
//  CircularButton.swift
//  Scribe
//
//  Created by Brennan Linse on 5/23/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import UIKit


@IBDesignable class CircularButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setUpView()
        }
    }
    
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = cornerRadius
    }
    
    
    
}
