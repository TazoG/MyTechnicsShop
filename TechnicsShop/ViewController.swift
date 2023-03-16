//
//  ViewController.swift
//  TechnicsShop
//
//  Created by Tazo Gigitashvili on 12.09.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let mail = "t@gmail.com"
    let psw = "1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    @IBAction func enterButton(_ sender: UIButton) {
        if emailField.text == "" || passwordField.text == "" {
            let alert = UIAlertController(title: "შეცდომა", message: "შეავსეთ ორივე ველი", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if !isValidEmail(emailField.text ?? "") {
            let alert = UIAlertController(title: "შეცდომა", message: "ელ-ფოსტა არ არის ვალიდური", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if emailField.text == mail && passwordField.text == psw {
            let catalogVC =  (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CatalogViewController") as? CatalogViewController)!
            self.navigationController?.pushViewController(catalogVC , animated: true)
        } else {
            let alert = UIAlertController(title: "შეცდომა", message: "ელ-ფოსტა ან პაროლი არასწორია", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}

