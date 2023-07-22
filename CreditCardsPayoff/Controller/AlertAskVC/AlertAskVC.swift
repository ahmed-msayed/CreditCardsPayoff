//
//  AlertAskVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 22/07/2023.
//

import UIKit

class AlertAskVC: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var noButtonView: UIButton!
    @IBOutlet weak var yesButtonView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }
    
    func initializeViews() {
        alertView.layer.cornerRadius = 21
        noButtonView.layer.cornerRadius = 14
        yesButtonView.layer.cornerRadius = 14
    }
    
    @IBAction func yesButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func noButtonClicked(_ sender: Any) {
        
    }
}
