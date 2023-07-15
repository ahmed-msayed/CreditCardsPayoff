//
//  SettingsVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 8/07/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol ProfileHeaderTapsDelegate: AnyObject {
    func didTapEdit()
}

class ProfileHeaderCell: UITableViewCell {
    
    weak var delegate: ProfileHeaderTapsDelegate?
    
    @IBOutlet weak var profileHeaderView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var editView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        bindData()
    }
    
    func bindData() {
        nameLabel.text = "\(UserVM.getLocalUser()?.firstName ?? "")" + " " + "\(UserVM.getLocalUser()?.lastName ?? "")"
        informationLabel.text = UserVM.getLocalUser()?.email
//        informationLabel.text = Auth.auth().currentUser?.email
    }
    
    func setupViews() {
        editView.layer.cornerRadius = 12
        profileHeaderView.layer.cornerRadius = 15
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        delegate?.didTapEdit()
    }
}
