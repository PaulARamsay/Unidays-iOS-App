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
        self.tableView.register(cells: [BreedTableViewCell.self,
                                        BreedTitleTableViewCell.self,
                                        ErrorTableViewCell.self])
        self.presenter.viewDidLoad()
        self.title = self.presenter.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
    
    @objc func viewFavouritesButtonTapped() {
        self.presenter.didTapViewFavourites()
    }
}

// MARK: -  BreedsView

extension BreedsViewController: BreedsView {
    
    func reloadTableView() {
        self.tableView.isScrollEnabled = self.presenter.numberOfRows() != 0
        self.tableView.reloadData()
    }
    
    func addViewFavouritesButton() {
        let item = UIBarButtonItem(image: UIImage(systemName: "star.fill"),
                                   style: .done,
                                   target: self,
                                   action: #selector(self.viewFavouritesButtonTapped))
        item.accessibilityLabel = "View Favourites"
        self.navigationItem.setRightBarButton(item, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension BreedsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.presenter.numberOfRows() == 0 {
            let view = UIView()
            view.backgroundColor = .none
            let indicatorView = UIActivityIndicatorView(style: .large)
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(indicatorView)
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            indicatorView.startAnimating()
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.presenter.numberOfRows() == 0 ? self.tableView.frame.height : 0
    }
}

// MARK: - UITableViewDataSource

extension BreedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.presenter.item(for: indexPath.row)
        switch row {
        case .breed(let breed):
            let cell = tableView.dequeue(cell: BreedTableViewCell.self, at: indexPath)
            cell.setupCell(breed: breed)
            return cell
            
        case .header(let title, let description):
            let cell = tableView.dequeue(cell: BreedTitleTableViewCell.self, at: indexPath)
            cell.setupCell(title: title, description: description)
            return cell
            
        case .error(let title, let description):
            let cell = tableView.dequeue(cell: ErrorTableViewCell.self, at: indexPath)
            cell.setupCell(title: title, description: description, delegate: self)
            return cell
            
        }
    }
}

// MARK: - ErrorTableViewCellDelegate

extension BreedsViewController: ErrorTableViewCellDelegate {

    func didTapRetry() {
        self.presenter.viewDidLoad()
    }
}
