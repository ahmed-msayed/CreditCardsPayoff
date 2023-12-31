//
//  AlertVC.swift
//  Tirhaly
//
//  Created by Ahmed Sayed on 10/12/2021.
//

import UIKit

class AlertVC: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertMessageLabel: UILabel!
    @IBOutlet weak var alertImage: UIImageView!
    
    var alertMessageText = ""
    var alertType = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        initializeGestures()
        dismissAlertAfter()
    }
    
    func initializeViews() {
        alertView.layer.cornerRadius = 21
        alertMessageLabel.text = alertMessageText
        alertImage.image = alertType == false ? UIImage(named: "check-circle-wrong-100") : UIImage(named: "check-circle-right-100")
    }
    
    func initializeGestures() {
        let alertViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(alertViewTapped(_:)))
        mainView.addGestureRecognizer(alertViewTapGestureRecognizer)
    }
    
    @IBAction func alertViewTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissAlertAfter() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            self.dismiss(animated: true, completion: nil)
        }
    }
}
