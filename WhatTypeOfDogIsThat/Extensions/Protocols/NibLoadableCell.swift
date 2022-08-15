//
//  NibLoadable.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation
import UIKit

protocol NibLoadableCell {
    
    static var nib: UINib { get }
    static var reuseIdentifier: String { get }
}

extension NibLoadableCell {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
