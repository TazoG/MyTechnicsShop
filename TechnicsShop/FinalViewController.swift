//
//  FinalView.swift
//  TechnicsShop
//
//  Created by Tazo Gigitashvili on 13.09.22.
//

import UIKit

class FinalViewController: UIViewController {
    
    @IBOutlet weak var finalImageView: UIImageView!
    @IBOutlet weak var finalLabel: UILabel!
    
    var isSuccess: Bool? = true
    var action: (()-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isSuccess! {
            finalImageView.image = UIImage(named: "tick")
            finalLabel.text = "გადახდა წარმატებით შესრულდა"
        } else {
            finalImageView.image = UIImage(named: "x")
            finalLabel.text = "სამწუხაროდ გადახდა ვერ მოხერხდა, სცადეთ თავიდან"
        }
    }
    
    @IBAction func backToCart(_ sender: UIButton) {
        if isSuccess! {
            dismiss(animated: true) {
                self.action?()
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}
