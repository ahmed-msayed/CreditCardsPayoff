//
//  AlertAskVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 22/07/2023.
//

import UIKit

class AlertAskVC: UIViewController {

    var alertMessage = ""
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var noButtonView: UIButton!
    @IBOutlet weak var yesButtonView: UIButton!
    @IBOutlet weak var alertMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }
    
    func initializeViews() {
        alertView.layer.cornerRadius = 21
        noButtonView.layer.cornerRadius = 14
        yesButtonView.layer.cornerRadius = 14
        alertMessageLabel.text = alertMessage
    }
    
    @IBAction func yesButtonClicked(_ sender: Any) {
        UserVM.removeLocalUser()
        UserDefaults.standard.synchronize()
        cardList = []
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MainNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController)
    }
    
    @IBAction func noButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
