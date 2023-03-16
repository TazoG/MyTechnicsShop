//
//  CatalogViewController.swift
//  TechnicsShop
//
//  Created by Tazo Gigitashvili on 12.09.22.
//

import UIKit
import SDWebImage

class CatalogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var catalogTableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var cartView: UIView!
    
    var products: [[Product]] = []
    static var balance: Double = 5000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catalogTableView.delegate = self
        catalogTableView.dataSource = self
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.cartTapped))
        self.cartView.addGestureRecognizer(gesture)
        
        NetworkService.shared.getData { productsData in
            var categories = Set<String>()
            for product in productsData.products {
                categories.insert(product.category)
            }
            
            for category in categories {
                let filtered = productsData.products.filter { $0.category == category }
                self.products.append(filtered)
            }

            DispatchQueue.main.async {
                self.catalogTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products[section].count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let view = UIView()
        label.frame = CGRect(x: 20, y: -10, width: 200, height: 30)
        label.text = "\(products[section].first!.category)"
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogCustomCell", for: indexPath) as! CatalogCustomCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let arrayForShow = products[indexPath.section]
        cell.myImageView.sd_setImage(with: URL(string: arrayForShow[indexPath.row].thumbnail), placeholderImage: nil)
        cell.myImageView.contentMode = .scaleAspectFit
        cell.titleLabel.text = arrayForShow[indexPath.row].title
        cell.stockLabel.text = "Stock: \(arrayForShow[indexPath.row].stock)"
        cell.priceLabel.text = "Price: \(arrayForShow[indexPath.row].price)"
        cell.stepperCountLabel.text = String(arrayForShow[indexPath.row].selectedQuantity ?? 0)

        
        cell.funcForExecute = { isIncrement in
            let currentCount = Int(self.countLabel.text!)!
            let currentPrice = Int(self.priceLabel.text!)!

            if isIncrement {
                self.countLabel.text = String(currentCount + 1)
                self.priceLabel.text = String(currentPrice + arrayForShow[indexPath.row].price)
                let current = arrayForShow[indexPath.row].selectedQuantity ?? 0
                arrayForShow[indexPath.row].selectedQuantity = current + 1
                
            } else {
                self.countLabel.text = String(currentCount == 0 ? 0 : currentCount - 1)
                self.priceLabel.text = String(currentPrice - arrayForShow[indexPath.row].price)
                let current = arrayForShow[indexPath.row].selectedQuantity ?? 0
                if current != 0 {
                    arrayForShow[indexPath.row].selectedQuantity = current - 1
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func clearAction () {
        priceLabel.text = "0"
        countLabel.text = "0"
        
        for i in 0...catalogTableView.numberOfSections-1 {
            
            for j in 0...catalogTableView.numberOfRows(inSection: i)-1 {
                let current = products[i][j].selectedQuantity ?? 0
                if current > 0 {
                    products[i][j].stock -= current
                }
                
                if let cell = catalogTableView.cellForRow(at: IndexPath(row: j, section: i)) as? CatalogCustomCell {
                    cell.stepperCountLabel.text = "0"
                    if current > 0 {
                        cell.stockLabel.text = String(products[i][j].stock)
                    }
                }
                
                
                products[i][j].selectedQuantity = 0
            }
        }
    }
    
    @IBAction func trashButton(_ sender: UIButton) {
        clearAction()
        
    }

    @objc func cartTapped(sender : UITapGestureRecognizer) {
        
        var finalProducts: [Product] = []
        
        for i in 0...catalogTableView.numberOfSections-1 {
            
            for j in 0...catalogTableView.numberOfRows(inSection: i)-1 {
                let current = products[i][j].selectedQuantity ?? 0
                if current > 0 {
                    finalProducts.append(products[i][j])
                }
            }
        }

        if !finalProducts.isEmpty {

            let paymentVC = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController)!
            paymentVC.paymentProducts.append(contentsOf: finalProducts)
            paymentVC.zeroAction = {self.clearAction()}
            
            self.navigationController?.pushViewController(paymentVC , animated: true)
        } else {
            let alert = UIAlertController(title: "შეცდომა", message: "გთხოვთ აირჩიოთ მინიმუმ ერთი პროდუქტი", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

