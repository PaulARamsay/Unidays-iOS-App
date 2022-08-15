//
//  BreedTableViewCell.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import UIKit

class BreedTableViewCell: UITableViewCell {

    @IBOutlet weak var breedTextLabel: UILabel!
    
    func setupCell(breed: [String : [String]]) {
        self.breedTextLabel.text = breed.first?.key
    }
}

// MARK: - NibLoadable

extension BreedTableViewCell: NibLoadableCell {}
