//
//  CardCell.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 15/07/2023.
//

import UIKit

class CardCell: UITableViewCell {
    
    let cardType: CardType = .other
    let currency = CurrencyVM.getLocalUserCurrency()?.currencyCode
    
    @IBOutlet weak var cardMainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var firstFourDigitsLabel: UILabel!
    @IBOutlet weak var dueLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeViews()
    }
    
    func initializeViews() {
        cardMainView.layer.cornerRadius = 15
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        //Add shadow
        self.layer.masksToBounds = false
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
    }
    
    func updateViews(card: Card) {
        titleLabel.text = card.title
        bankLabel.text = card.bank
        firstFourDigitsLabel.text = card.number == "" ? "XXXX-XXXX-XXXX-XXXX" : "XXXX-XXXX-XXXX-\(card.number.suffix(4))"
        let due = card.limit - card.available
        dueLabel.text = "\(due.formatted())" + " \(currency ?? "")"
        availableLabel.text = "\(card.available.formatted())" + " \(currency ?? "")"
        
        switch card.type {
        case "mastercard":
            cardImage.image = UIImage(named: "mastercard-100")
        case "visa":
            cardImage.image = UIImage(named: "visa-100")
        case "other":
            cardImage.image = UIImage(named: "magnetic-card-100")
        case .none:
            return
        case .some(_):
            return
        }
    }
}
