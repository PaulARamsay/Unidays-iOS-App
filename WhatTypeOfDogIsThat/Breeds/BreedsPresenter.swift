//
//  BreedsPresenter.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation

protocol BreedsView: AnyObject {
    
}

class BreedsPresenter {
    
    private weak var view: BreedsView?
    
    // MARK: - Initialiser
    init(view: BreedsView) {
        self.view = view
    }
}
