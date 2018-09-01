//
//  UIViewController+Extensions.swift
//  TicketsAPP
//
//  Created by ricardo hernandez  on 8/22/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func show(errorMessage: String) {
        let alert = UIAlertController(title: NSLocalizedString("An error has occurred", comment: "error"), message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
