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
    
}

@IBDesignable class DesignalbleView: UIImageView {
    
    @IBInspectable var cornerRaduis: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRaduis
        }
        
    }


}
