//
//  DesignalbeButton.swift
//  Where You @
//
//  Created by Nick Cowart on 3/1/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

@IBDesignable class DesignalbeButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    
    
}
