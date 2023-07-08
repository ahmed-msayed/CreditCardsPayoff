//
//  TermsConditionsCell.swift
//  Tirhaly
//
//  Created by Ahmed Sayed on 30/10/2021.
//

import UIKit

protocol TermsConditionsTapsDelegate: AnyObject {
    func didTapTerms()
}

class TermsConditionsCell: UITableViewCell {

    weak var delegate: TermsConditionsTapsDelegate?
    
    @IBOutlet weak var termsConditionsView: UIView!
    @IBOutlet weak var termsArrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        initializeGestures()
        setupArrowViews()
    }
    
    func setupViews() {
        termsConditionsView.layer.cornerRadius = 15
        termsConditionsView.layer.shadowColor = UIColor.lightGray.cgColor
        termsConditionsView.layer.shadowOffset = CGSize(width: 1, height: 1)
        termsConditionsView.layer.shadowRadius = 4
        termsConditionsView.layer.shadowOpacity = 0.5
        termsConditionsView.layer.masksToBounds = false
    }
    
    func setupArrowViews() {
//        if Locale.current.languageCode == "en" {
//            termsArrowImage.image = UIImage(named: "chevron-right-grey")
//        } else if Locale.current.languageCode == "ar" {
//            termsArrowImage.image = UIImage(named: "chevron-left-grey")
//        }
    }
    
    func initializeGestures() {
        let termsTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapTermsConditionsView(_:)))
        termsConditionsView.addGestureRecognizer(termsTapGestureRecognizer)
    }
    
    @objc func didTapTermsConditionsView(_ sender: UITapGestureRecognizer) {
        delegate?.didTapTerms()
    }
}
