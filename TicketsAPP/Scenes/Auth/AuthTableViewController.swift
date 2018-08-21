//
//  AuthTableViewController.swift
//  TicketsAPP
//
//  Created by ricardo hernandez  on 8/15/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import UIKit

class AuthTableViewController: UITableViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        emailTextField.text = "a.ricardohg@gmail.com"
        passwordTextField.text = "test"
    }

    @IBAction func loginAction(_ sender: Any) {
        Session.shared.login(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
