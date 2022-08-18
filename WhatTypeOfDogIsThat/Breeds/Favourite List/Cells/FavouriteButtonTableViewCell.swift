//
//  FavouriteButtonTableViewCell.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 18/08/2022.
//

import UIKit

protocol FavouriteButtonTableViewCellDelegate: AnyObject {
    func didTapFavourite(favourited: Bool)
}

class FavouriteButtonTableViewCell: UITableViewCell {

    @IBOutlet private weak var favouriteButton: UIButton!
    
    private weak var delegate: FavouriteButtonTableViewCellDelegate?
    
    var favourited: Bool = false {
        didSet {
            self.delegate?.didTapFavourite(favourited: self.favourited)
            self.setupButtonFor(favouritedBreed: self.favourited)
        }
    }
    
    func setupCell(delegate: FavouriteButtonTableViewCellDelegate,
                   breedFavourited: Bool) {
        self.delegate = delegate
        self.favourited = breedFavourited
    }
    
    private func setupButtonFor(favouritedBreed: Bool) {
        let title = favouritedBreed ? "Favourited" : "Favourite"
        self.favouriteButton.setTitle(title,
                                      for: .normal)
        
        let image = favouritedBreed ? "star.fill" : "star"
        self.favouriteButton.setImage(UIImage(systemName: image),
                                      for: .normal)
    }
    
    @IBAction func didTapFavouriteButton(_ sender: Any) {
        self.favourited.toggle()
    }
}

// MARK: NibLoadable

extension FavouriteButtonTableViewCell: NibLoadableCell {}
