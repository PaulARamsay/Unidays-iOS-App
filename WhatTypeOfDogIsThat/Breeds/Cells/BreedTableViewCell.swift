//
//  BreedTableViewCell.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import UIKit

class BreedTableViewCell: UITableViewCell {

    @IBOutlet weak var breedTextLabel: UILabel!
    
    func setupCell(breedName: String) {
        self.breedTextLabel.text = breedName
    }
}

// MARK: - NibLoadable

extension BreedTableViewCell: NibLoadableCell {}
