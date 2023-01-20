//
//  CatalogCustomCell.swift
//  TechnicsShop
//
//  Created by Tazo Gigitashvili on 12.09.22.
//

import UIKit

class CatalogCustomCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stepperCountLabel: UILabel!
        
    var funcForExecute: ((Bool)->Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stepperCountLabel.text = "0"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func minusButton(_ sender: UIButton) {
        let current = Int(stepperCountLabel.text!)!
        if current != 0 {
            stepperCountLabel.text = String(current - 1)
            funcForExecute!(false)
        }
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        let current = Int(stepperCountLabel.text!)!
        stepperCountLabel.text = String(current + 1)
        funcForExecute!(true)
    }
    
}

