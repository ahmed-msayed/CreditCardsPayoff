//
//  AddCardVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 15/07/2023.
//

import UIKit
import CoreData

class AddCardVC: UIViewController, UITextFieldDelegate {
    
    var isDismissed: (() -> Void)?
    var cardType: CardType = .other
    
    @IBOutlet var viewCardBackground: UIView!
    @IBOutlet var viewCard: UIView!
    @IBOutlet var imageCard: UIImageView!
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var bankNameTextField: UITextField!
    @IBOutlet weak var holderNameTextField: UITextField!
    @IBOutlet weak var expiryDateTextField: UITextField!
    
    @IBOutlet weak var cardTitleTextField: UITextField!
    @IBOutlet weak var cardLimitTextField: UITextField!
    @IBOutlet weak var availableAmountTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var addCardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        loadData()
    }
    
    func initializeViews() {
        viewCardBackground.layer.borderWidth = 1
        viewCardBackground.layer.borderColor = UIColor.blue.cgColor
        viewCard.layer.borderWidth = 1
        viewCard.layer.borderColor = UIColor.blue.cgColor
        cardNumberTextField.delegate = self
    }
    
    func loadData() {
        expiryDateTextField.text = "02/2025"
    }
    
    // MARK: - User actions
    
    @IBAction func actionAddCard(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)
        let newCard = Card(entity: entity!, insertInto: context)
        newCard.id = cardList.count as NSNumber
        guard let user = UserVM.getLocalUser() else {return}
        newCard.email = user.email
        newCard.number = cardNumberTextField.text
        newCard.bank = bankNameTextField.text
        newCard.holder = holderNameTextField.text
        newCard.expire = expiryDateTextField.text
        newCard.title = cardTitleTextField.text
        newCard.limit = cardLimitTextField.text
        newCard.available = availableAmountTextField.text
        newCard.notes = notesTextView.text
        newCard.type = "\(cardType)"
        do
        {
            try context.save()
            cardList.append(newCard)
            dismissModalVC()
        }
        catch {
            self.showAlert(message: "Card Save Error", type: false)
        }
    }
    
    func dismissModalVC() {
        self.isDismissed?()
        dismiss(animated: true)
        notificationCenterReloadHomeTable()
    }
    
    func notificationCenterReloadHomeTable() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTableView"), object: nil)
    }
    
    @IBAction func cardNumberChanged(_ sender: UITextField) {
        let text = cardNumberTextField.text
        
        if text?.prefix(1) == "5" {
            imageCard.image = UIImage(named: "mastercard-100")
            cardType = .mastercard
        } else if text?.prefix(1) == "4" {
            imageCard.image = UIImage(named: "visa-100")
            cardType = .visa
        } else {
            imageCard.image = UIImage(named: "magnetic-card-100")
            cardType = .other
        }
    }
}
