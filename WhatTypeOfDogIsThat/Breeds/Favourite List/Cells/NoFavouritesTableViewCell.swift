//
//  NoFavouritesTableViewCell.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 18/08/2022.
//

import UIKit

class NoFavouritesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.text = "No favourites"
        self.descriptionLabel.text = """
        Oh no, it looks like you haven't favourited any pets. Why not go back to the breeds list and select some!
        """
    }
}

// MARK: - NibLoadableCell

extension NoFavouritesTableViewCell: NibLoadableCell {}
