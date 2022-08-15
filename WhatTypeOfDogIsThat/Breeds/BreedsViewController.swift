//
//  BreedsViewController.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import UIKit

protocol BreedsViewPresenting: AnyObject {
    func numberOfRows() -> Int
    func item(for row: Int) -> [String : [String]]
}

class BreedsViewController: UIViewController {

    var presenter: BreedsViewPresenting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: -  BreedsView

extension BreedsViewController: BreedsView {}

// MARK: - UITableViewDelegate

extension BreedsViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension BreedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO
    }
}
