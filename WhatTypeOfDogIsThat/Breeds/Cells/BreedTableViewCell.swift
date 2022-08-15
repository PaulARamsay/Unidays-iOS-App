//
//  BreedTableViewCell.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import UIKit
import SDWebImage

class BreedTableViewCell: UITableViewCell {

    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var breedTextLabel: UILabel!
    @IBOutlet weak var subBreedsTextLabel: UILabel!
    
    func setupCell(breed: Breed) {
        self.breedTextLabel.text = breed.breedName
        self.breedImageView.layer.cornerRadius = 50
        self.subBreedsTextLabel.text = "\(breed.subBreeds.count) Sub-breeds!"
        
        guard let imageName = breed.breedImageList.first,
                let breedImageUrl = URL(string: imageName) else { return }
        
        self.breedImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.breedImageView.sd_setImage(with: breedImageUrl)
    }
}

// MARK: - NibLoadable

extension BreedTableViewCell: NibLoadableCell {}
