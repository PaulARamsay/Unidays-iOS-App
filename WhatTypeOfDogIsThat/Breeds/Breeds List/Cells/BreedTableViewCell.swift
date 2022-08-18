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
    
    var isFavourited: Bool = false {
        didSet {
            self.setupCellFor(favourited: isFavourited)
        }
    }
    
    func setupCell(breed: Breed,
                   favourited: Bool = false) {
        self.isFavourited = favourited
        self.breedTextLabel.text = breed.breedName
        self.breedImageView.layer.cornerRadius = 35
        self.subBreedsTextLabel.text = breed.subBreeds.count == 0 ? "" : "\(breed.subBreeds.count) Sub-breeds!"
        self.subBreedsTextLabel.isHidden = breed.subBreeds.count == 0
        self.accessibilityLabel = "\(breed.breedName) breed"
        
        guard let imageName = breed.breedImageList.first,
                let breedImageUrl = URL(string: imageName) else { return }
        
        self.breedImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.breedImageView.sd_setImage(with: breedImageUrl)
        self.accessoryType = .disclosureIndicator
    }
    
    private func setupCellFor(favourited: Bool) {
        self.breedImageView.layer.borderWidth = 3
        self.breedImageView.layer.borderColor = !favourited ? UIColor.systemBlue.cgColor : .none
    }
}

// MARK: - NibLoadable

extension BreedTableViewCell: NibLoadableCell {}
