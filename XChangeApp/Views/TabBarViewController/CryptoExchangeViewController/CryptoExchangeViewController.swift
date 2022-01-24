//
//  CryptoExchangeViewController.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/21/22.
//

import UIKit

class CryptoExchangeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var searchBar: UISearchBar = UISearchBar()
    var tableView: UITableView = UITableView()
    var refreshControl = UIRefreshControl()
    
    var viewModel: CryptoExchangeViewModelProtocol
    
    init(viewModel: CryptoExchangeViewModelProtocol) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.insetsLayoutMarginsFromSafeArea = true
        viewModel.viewDidLoad()
        viewModel.view = self
        super.viewDidLoad()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalToSuperview().offset(8)
            make.trailingMargin.equalToSuperview().offset(-8)
            make.height.equalTo(80)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottomMargin).offset(8)
            make.leadingMargin.equalToSuperview().offset(8)
            make.trailingMargin.equalToSuperview().offset(-8)
            make.bottomMargin.equalToSuperview().offset(-10)
        }
        tableView.register(UINib(nibName: String(describing:ExchangeTableViewCell.self), bundle: nil), forCellReuseIdentifier: XChangeConstants.exchangeCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCryptoDataCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ExchangeTableViewCell = tableView.dequeueReusableCell(withIdentifier: XChangeConstants.exchangeCellIdentifier, for: indexPath) as? ExchangeTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(data: viewModel.getCryptoData(withIndex: indexPath.row))
        if indexPath.row == viewModel.getCryptoDataCount() - 1 && indexPath.row > 12{
            viewModel.fetchCryptoExchangeData()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let changeCryptoVC = ChangeCryptoExchangeViewController.instantiate() as? ChangeCryptoExchangeViewController else {
            return
        }
        let _ = changeCryptoVC.view
        changeCryptoVC.setupView(data: viewModel.getCryptoData(withIndex: indexPath.row))
        changeCryptoVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(changeCryptoVC, animated: true)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.initialFetchCryptoExchangeData()
        refreshControl.endRefreshing()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        viewModel.filterCyrptoExchangeData(withText: searchText)
    }

}

extension CryptoExchangeViewController: CryptoExchangeViewControllerProtocol {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}
