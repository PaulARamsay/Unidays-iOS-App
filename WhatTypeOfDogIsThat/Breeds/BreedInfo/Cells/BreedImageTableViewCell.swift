//
//  BreedImageTableViewCell.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 17/08/2022.
//

import UIKit
import SDWebImage

class BreedImageTableViewCell: UITableViewCell {

    @IBOutlet private weak var breedImageView: UIImageView!
    
    func setupCellWith(imageUrlString: String) {
        guard let imageUrl = URL(string: imageUrlString) else { return }
        self.breedImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.breedImageView.sd_setImage(with: imageUrl)
    }
}

// MARK: - BreedImageTableViewCe

extension BreedImageTableViewCell: NibLoadableCell {}
