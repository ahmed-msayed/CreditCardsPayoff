//
//  LogoutCell.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 17/07/2023.
//

import UIKit

protocol LogoutTapsDelegate: AnyObject {
    func didTapLogout()
}

class LogoutCell: UITableViewCell {

    weak var delegate: LogoutTapsDelegate?

    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var logoutArrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        initializeGestures()
        setupArrowViews()
    }

    func setupViews() {
        logoutView.layer.cornerRadius = 15
        logoutView.layer.shadowColor = UIColor.lightGray.cgColor
        logoutView.layer.shadowOffset = CGSize(width: 1, height: 1)
        logoutView.layer.shadowRadius = 4
        logoutView.layer.shadowOpacity = 0.5
        logoutView.layer.masksToBounds = false
    }
    
    func setupArrowViews() {
//        if Locale.current.languageCode == "en" {
//            termsArrowImage.image = UIImage(named: "chevron-right-grey")
//        } else if Locale.current.languageCode == "ar" {
//            termsArrowImage.image = UIImage(named: "chevron-left-grey")
//        }
    }
    
    func initializeGestures() {
        let logoutTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLogoutView(_:)))
        logoutView.addGestureRecognizer(logoutTapGestureRecognizer)
    }
    
    @objc func didTapLogoutView(_ sender: UITapGestureRecognizer) {
        delegate?.didTapLogout()
    }
    
}
