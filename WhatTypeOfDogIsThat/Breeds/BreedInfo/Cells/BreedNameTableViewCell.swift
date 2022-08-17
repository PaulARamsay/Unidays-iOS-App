//
//  BreedNameTableViewCell.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 17/08/2022.
//

import UIKit

class BreedNameTableViewCell: UITableViewCell {

    @IBOutlet private weak var breedTitleLabel: UILabel!

    func setupCellWith(title: String) {
        self.breedTitleLabel.text = title
    }
}

// MARK: - NibLoadable

extension BreedNameTableViewCell: NibLoadableCell {}
