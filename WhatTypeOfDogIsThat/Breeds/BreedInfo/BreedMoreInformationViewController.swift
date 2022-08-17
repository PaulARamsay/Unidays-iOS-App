//
//  BreedMoreInformationViewController.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 17/08/2022.
//

import UIKit
import SDWebImage

protocol BreedMoreInformationView: AnyObject {
    
    func reloadTableView()
}

class BreedMoreInformationViewController: UIViewController {

    @IBOutlet weak var breedTableView: UITableView!
    
    var presenter: BreedMoreInformationPresenting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.breedTableView.register(cells: [BreedNameTableViewCell.self,
                                             BreedImageTableViewCell.self])
        self.presenter.viewDidLoad()
        self.title = self.presenter.title()
    }
}

// MARK: - BreedMoreInformationView

extension BreedMoreInformationViewController: BreedMoreInformationView {
    
    func reloadTableView() {
        self.breedTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension BreedMoreInformationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.presenter.item(for: indexPath.section, row: indexPath.row)
        switch item {
        case .subBreed(breedName: let breedName):
            let cell = tableView.dequeue(cell: BreedNameTableViewCell.self, at: indexPath)
            cell.setupCellWith(title: breedName)
            return cell
            
        case .image(imageName: let imageName):
            let cell = tableView.dequeue(cell: BreedImageTableViewCell.self, at: indexPath)
            cell.setupCellWith(imageUrlString: imageName)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.presenter.titleFor(section: section)
    }
}
