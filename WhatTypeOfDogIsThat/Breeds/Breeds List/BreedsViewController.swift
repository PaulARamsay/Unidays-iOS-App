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
        self.tableView.reloadData()
    }
    
    func addViewFavouritesButton() {
        let item = UIBarButtonItem(image: UIImage(systemName: "star.fill"),
                                   style: .done,
                                   target: self,
                                   action: #selector(self.viewFavouritesButtonTapped))
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
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.3)
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicatorView)
        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorView.startAnimating()
        return view
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
        let breed = self.presenter.item(for: indexPath.row)
        let cell = tableView.dequeue(cell: BreedTableViewCell.self, at: indexPath)
        cell.setupCell(breed: breed)
        return cell
    }
}
