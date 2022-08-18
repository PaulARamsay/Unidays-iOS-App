//
//  ErrorTableViewCell.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 18/08/2022.
//

import UIKit

protocol ErrorTableViewCellDelegate: AnyObject {
    func didTapRetry()
}

class ErrorTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    weak var delegate: ErrorTableViewCellDelegate?
    
    func setupCell(title: String,
                   description: String,
                   delegate: ErrorTableViewCellDelegate) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.delegate = delegate
    }
    
    @IBAction func didTapRetry(_ sender: Any) {
        self.delegate?.didTapRetry()
    }
}

// MARK: - NibLoadableCell

extension ErrorTableViewCell: NibLoadableCell {}
