//
//  LeftPaddedTextField.swift
//  VzLife
//
//  Created by FOI on 30/11/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit

class LeftPaddedTextField: UITextField {

 
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }

}
