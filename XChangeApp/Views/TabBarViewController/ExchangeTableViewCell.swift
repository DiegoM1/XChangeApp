//
//  ExchangeTableViewCell.swift
//  XChangeApp
//
//  Created by Diego Sebastian Monteagudo Diaz on 1/22/22.
//

import UIKit

class ExchangeTableViewCell: UITableViewCell {

    @IBOutlet private weak var exchangeLabel: UILabel!
    @IBOutlet private weak var exchangeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(data: ExchangeCellDataModel) {
        exchangeLabel.text = String(format: "%.2f", data.exchange)
        titleLabel.text = data.title
        exchangeImageView.image = UIImage(named: data.image) ?? UIImage(systemName: data.image)
        
    }
    

}
