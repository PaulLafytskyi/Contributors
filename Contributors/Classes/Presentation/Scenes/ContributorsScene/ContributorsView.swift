//
//  ContributorsView.swift
//  Contributors
//
//  Created by Poul Lafitskiy on 3/4/18.
//  Copyright © 2018 PLF. All rights reserved.
//

import UIKit

protocol ContributorsView: UIPresentable {
    func makeUpdate()
    func showViewController(viewController: UIViewController)
}

class ContributorsViewController: UIViewController, ContributorsView, UITableViewDataSource, UITableViewDelegate {
    var presenter: ContributorsPresenter!
    let tableView = UITableView()

    //MARK-: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        makeLayout()
        presenter.viewDidReady()
    }

    private func setupTableView () {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        self.tableView.register(ContributorCell.nib(), forCellReuseIdentifier: ContributorCell.reuseIdentifier())
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func makeLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    //MARK:- ContributorsView

    func makeUpdate() {
        tableView.reloadData()
    }

    func showViewController(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    //MARK:- UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRow()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContributorCell.reuseIdentifier()) as! ContributorCell
        guard let user = presenter.dataAtIndex(index: indexPath.row) else {
            return cell
        }
        cell.loginNameLabel.text = user.login
        cell.avatarImageView.set_remote_image(url: user.avatar)
        return cell
    }

    //MARK:- UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItemAtIndex(index: indexPath.row)
    }
}
