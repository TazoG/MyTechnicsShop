//
//  PaymentViewController.swift
//  TechnicsShop
//
//  Created by Tazo Gigitashvili on 13.09.22.
//

import UIKit

class PaymentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var deliveryPriceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var deliveryPrice = 50
    var paymentProducts: [Product] = []
    var zeroAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "გადახდის გვერდი"
        paymentTableView.delegate = self
        paymentTableView.dataSource = self
        
        deliveryPriceLabel.text = String(deliveryPrice)
        calculateFinalPrices()
    }
    
    func calculateFinalPrices() {
        var totalPrice = 0
        for i in paymentProducts {
            totalPrice += i.price * i.selectedQuantity!
        }
        totalPriceLabel.text = String(totalPrice)
        let feePrice = Double(totalPrice) * 0.1
        feeLabel.text = String(format: "%.2f", feePrice)
        let total = Double(totalPrice) + feePrice + Double(deliveryPrice)
        totalLabel.text = String(format: "%.2f", total)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        paymentProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCustomCell", for: indexPath) as! PaymentCustomCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.paymentImageView.sd_setImage(with: URL(string: paymentProducts[indexPath.row].thumbnail), placeholderImage: nil)
        cell.titleLabel.text = paymentProducts[indexPath.row].title
        cell.countLabel.text = String(paymentProducts[indexPath.row].selectedQuantity!)
        cell.priceLabel.text = String(paymentProducts[indexPath.row].selectedQuantity! * paymentProducts[indexPath.row].price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }

    @IBAction func paymentButton(_ sender: UIButton) {
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.spinner.stopAnimating()
            let finalVC = self.storyboard?.instantiateViewController(withIdentifier: "FinalViewController") as! FinalViewController
            finalVC.action = {
                self.zeroAction?()
                self.navigationController?.popViewController(animated: true)
            }
            var balanceIsEnough = CatalogViewController.balance >= Double(self.totalLabel.text!)!
            
            finalVC.isSuccess = balanceIsEnough
            if balanceIsEnough {
                CatalogViewController.balance -= Double(self.totalLabel.text!)!
            }
            self.present(finalVC, animated: true)
        }
        
    }
    
}
