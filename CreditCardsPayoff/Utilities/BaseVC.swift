//
//  BaseVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 17/07/2023.
//

import UIKit
import FittedSheets

class BaseVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myTabbar = tabBar as? FloatingTabbar {
            myTabbar.centerButtonActionHandler = {
                print("Center Button Tapped")
                
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCardVC") as? AddCardVC {
                    let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(750)])
                    sheetController.cornerRadius = 35
                    
                    viewController.isDismissed = { [weak self] in
//                        self?.tableView.reloadData()
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            self?.showAlert(message: "Card Added successfully!", type: true)
                        }
                    }
                    self.present(sheetController, animated: true, completion: nil)
                }
            }
        }
    }
}
