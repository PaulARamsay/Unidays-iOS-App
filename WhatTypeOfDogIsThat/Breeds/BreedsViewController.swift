//
//  BreedsViewController.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import UIKit

class BreedsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: BreedsViewPresenting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(cells: [BreedTableViewCell.self])
        self.presenter.viewDidLoad()
    }
}

// MARK: -  BreedsView

extension BreedsViewController: BreedsView {
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension BreedsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectItem(at: indexPath.row)
    }
}

// MARK: - UITableViewDataSource

extension BreedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let breed = self.presenter.item(for: indexPath.row)
        let cell = tableView.dequeue(cell: BreedTableViewCell.self, at: indexPath)
        cell.setupCell(breed: breed)
        return cell
    }
}
