//
//  ExchangeViewController.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/21/22.
//

import UIKit
import SnapKit

class ExchangeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentCurrencyLabel: UILabel = UILabel()
    var tableView: UITableView = UITableView()
    var refreshControl = UIRefreshControl()
    
    var viewModel: ExchangeViewModelProtocol
    
    init(viewModel: ExchangeViewModelProtocol) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        viewModel.viewDidLoad()
        viewModel.view = self
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(currentCurrencyLabel)
        currentCurrencyLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalToSuperview().offset(8)
            make.trailingMargin.equalToSuperview().offset(-8)
            make.height.equalTo(80)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(currentCurrencyLabel.snp.bottomMargin).offset(8)
            make.leadingMargin.equalToSuperview().offset(8)
            make.trailingMargin.equalToSuperview().offset(-8)
            make.bottomMargin.equalToSuperview()
        }
        tableView.register(UINib(nibName: String(describing:ExchangeTableViewCell.self), bundle: nil), forCellReuseIdentifier: XChangeConstants.exchangeCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
    }
    
   
    @objc func refresh(_ sender: AnyObject) {
        viewModel.pullToRefresh()
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidLoad()
        currentCurrencyLabel.text = viewModel.getCurrentCurrencyText()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCountExchange()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSelected = viewModel.getExchangeData(withIndex: indexPath.row)
        viewModel.getPairExchangeRate(dataSelected.title) {
            DispatchQueue.main.async {
                if let changeExchange = ChangeExchangeViewController.instantiate() as? ChangeExchangeViewController {
                    let _ = changeExchange.view
                    changeExchange.setupView(withExchangeSelected: dataSelected, exchangeRate: self.viewModel.getPairExchangeRate())
                    changeExchange.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(changeExchange, animated: true)
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ExchangeTableViewCell = tableView.dequeueReusableCell(withIdentifier: XChangeConstants.exchangeCellIdentifier, for: indexPath) as? ExchangeTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.getExchangeData(withIndex: indexPath.row)
        cell.setupCell(data: data)
        return cell
    }
}

extension ExchangeViewController: ExchangeViewControllerProtocol {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
