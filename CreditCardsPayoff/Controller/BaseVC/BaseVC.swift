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
        self.delegate = self
        setupMiddleButton()
        tabBar.tintColor = UIColor(named: "tabBarSelectedTab")
        tabBar.unselectedItemTintColor = .gray
    }
    
    // TabBarButton – Setup Middle Button
    func setupMiddleButton() {
        //STYLE THE BUTTON
        let containerView = UIView(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 50, height: 50))
        self.tabBar.addSubview(containerView)
        containerView.backgroundColor = .clear
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 10
        containerView.layer.masksToBounds = false
        
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 50, height: 50))
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(middleButton)
        middleButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        middleButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        middleButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        middleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        middleButton.setIcon(icon: .fontAwesomeSolid(.plus), iconSize: 30.0, color: UIColor.black, backgroundColor: UIColor.lightGray, forState: .normal)
        middleButton.setGradientBackground(colorOne: .systemTeal, colorTwo: .systemGreen)
        middleButton.layer.cornerRadius = 25
        middleButton.layer.masksToBounds = true
        
        //add to the tabbar and add click event
        middleButton.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCardVC") as? AddCardVC {
            let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(750)])
            sheetController.cornerRadius = 35
            
            viewController.isDismissed = { [weak self] in
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self?.showAlert(message: "Card Added successfully!", type: true)
                }
            }
            self.present(sheetController, animated: true, completion: nil)
        }
    }
    
    // TabBar Transition
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        return true
    }
}

