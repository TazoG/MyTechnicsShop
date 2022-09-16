//
//  PaymentCustomCell.swift
//  TechnicsShop
//
//  Created by Tazo Gigitashvili on 13.09.22.
//

import UIKit

class PaymentCustomCell: UITableViewCell {

    @IBOutlet weak var paymentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
