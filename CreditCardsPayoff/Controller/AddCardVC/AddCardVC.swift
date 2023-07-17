//
//  AddCardVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 15/07/2023.
//

import UIKit
import CoreData

class AddCardVC: UIViewController {
    
    var isDismissed: (() -> Void)?
    
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
    }
    
    func loadData() {
        expiryDateTextField.text = "02/2021"
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
    }
}
