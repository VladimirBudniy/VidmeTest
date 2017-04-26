//
//  LoginViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/26/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, AlertViewController {

    @IBOutlet var loginTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var loginButton: UIButton?
    
    let alertViewController = UIAlertController()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Login Action
    
    
    @IBAction func onLoginButton(_ sender: Any) {
        
    }
    
    // MARK: - Private
    
    private func showAlertController(message: String) {
        self.present(self.alertViewController(message: message), animated: true, completion: nil)
    }
    
    // MARK: - Validation
    
    private func isValidEmail(text: String?) -> Bool {
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", CheckEmailRange().emailRange)
        let bool = emailCheck.evaluate(with: text)
        if bool == false {
            self.showAlertController(message: AlertControllerConst().emailMessage)
        }
        
        return bool
    }
    
    
    private func checkWhitespace(string: String?) -> Bool {
        if string == " " {
            self.showAlertController(message: AlertControllerConst().whitespaceMessage)
            return false
        }
        
        return true
    }
    
    // MARK: - UITextFieldDelegate Protocol Reference
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case let textField where textField == self.loginTextField:
            let bool = self.isValidEmail(text: textField.text)
            if bool == false {
                textField.text = ""
            }
            
            self.passwordTextField?.becomeFirstResponder()
            return bool
            
        case let textField where textField == self.passwordTextField:
            let bool = self.passwordTextField?.endEditing(true)
            return bool!
            
        default:
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case let textField where textField == self.loginTextField:
            return true
            
        case let textField where textField == self.passwordTextField:
            return self.checkWhitespace(string: string)
            
        default:
            return true
        }
    }

}
