//
//  BreedTitleTableViewCell.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 17/08/2022.
//

import UIKit

class BreedTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupCell(title: String,
                   description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        
    }
}

// MARK: - NibLoadableCell

extension BreedTitleTableViewCell: NibLoadableCell {}
