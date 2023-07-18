//
//  BaseVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 17/07/2023.
//

import UIKit
import FittedSheets
import SwiftIcons

class BaseVC: UITabBarController, UITabBarControllerDelegate {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let myTabbar = tabBar as? FloatingTabbar {
//            myTabbar.centerButtonActionHandler = {
//                print("Center Button Tapped")
//
//                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCardVC") as? AddCardVC {
//                    let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(750)])
//                    sheetController.cornerRadius = 35
//
//                    viewController.isDismissed = { [weak self] in
////                        self?.tableView.reloadData()
//                        DispatchQueue.main.asyncAfter(deadline: .now()) {
//                            self?.showAlert(message: "Card Added successfully!", type: true)
//                        }
//                    }
//                    self.present(sheetController, animated: true, completion: nil)
//                }
//            }
//        }
        
        self.delegate = self
        setupMiddleButton()
        
    }
    
    
    // TabBarButton – Setup Middle Button
    func setupMiddleButton() {
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 50, height: 50))

        //STYLE THE BUTTON YOUR OWN WAY

        middleBtn.setIcon(icon: .fontAwesomeSolid(.plus), iconSize: 30.0, color: UIColor.black, backgroundColor: UIColor.lightGray, forState: .normal)
        middleBtn.layer.cornerRadius = middleBtn.frame.size.width / 2.0
        middleBtn.layer.shadowOffset = CGSize(width:0, height:0)
        middleBtn.layer.shadowRadius = 10
        middleBtn.layer.shadowColor = UIColor.gray.cgColor
        middleBtn.layer.shadowOpacity = 0.5
        
//        middleBtn.applyGradient(colors: colorBlueDark.cgColor,colorBlueLight.cgColor])
        
        //add to the tabbar and add click event
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
    }

    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
//        self.selectedIndex = 1   //to select the middle tab. use "1" if you have only 3 tabs.
        print("hello")
    }
}
