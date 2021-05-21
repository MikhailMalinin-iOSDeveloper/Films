//
//  UIViewController+Ext.swift
//  Films
//
//  Created by iOS_Coder on 04.05.2021.
//

import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
