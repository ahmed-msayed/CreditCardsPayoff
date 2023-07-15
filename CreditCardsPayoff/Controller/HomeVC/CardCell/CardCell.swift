//
//  CardCell.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 15/07/2023.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var cardMainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var firstFourDigitsLabel: UILabel!
    @IBOutlet weak var dueLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        cardMainView.layer.cornerRadius = 15
        cardMainView.layer.shadowColor = UIColor.lightGray.cgColor
        cardMainView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cardMainView.layer.shadowRadius = 4
        cardMainView.layer.shadowOpacity = 0.5
        cardMainView.layer.masksToBounds = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
