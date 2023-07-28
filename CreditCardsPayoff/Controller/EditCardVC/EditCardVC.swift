//
//  EditCardVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 16/07/2023.
//

import UIKit
import CoreData

class EditCardVC: UIViewController {
    
    var saveAndDismissed: (() -> Void)?
    var deleteAndDismissed: (() -> Void)?
    var selectedCard: Card? = nil
    
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
        loadData()
    }
    
    func loadData() {
        cardNumberTextField.text = selectedCard?.number
        bankNameTextField.text = selectedCard?.bank
        holderNameTextField.text = selectedCard?.holder
        expiryDateTextField.text = selectedCard?.expire
        cardTitleTextField.text = selectedCard?.title
        cardLimitTextField.text = "\(selectedCard?.limit ?? 0)"
        availableAmountTextField.text = "\(selectedCard?.available ?? 0)"
        notesTextView.text = selectedCard?.notes
        
        if selectedCard?.type == "mastercard" {
            imageCard.image = UIImage(named: "mastercard-100")
        } else if selectedCard?.type == "visa" {
            imageCard.image = UIImage(named: "visa-100")
        } else {
            imageCard.image = UIImage(named: "magnetic-card-100")
        }
    }
    
    @IBAction func saveChangesButtonClick(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let card = result as! Card
                if (card == selectedCard) {
                    card.number = cardNumberTextField.text
                    card.bank = bankNameTextField.text
                    card.holder = holderNameTextField.text
                    card.expire = expiryDateTextField.text
                    card.title = cardTitleTextField.text
                    guard let limit = Double(cardLimitTextField.text ?? "") else {return}
                    card.limit = limit
                    guard let available = Double(availableAmountTextField.text ?? "") else {return}
                    card.available = available
                    card.notes = notesTextView.text
                    try context.save()
                    saveAndDismissModalVC()
                }
            }
        }
        catch
        {
            self.showAlert(message: "Getting Data Failed", type: false)
        }
    }
    
    @IBAction func deleteCardButtonClick(_ sender: Any) {
        deleteAndDismissModalVC()
    }
    
    func saveAndDismissModalVC() {
        self.saveAndDismissed?()
        dismiss(animated: true)
    }
    
    func deleteAndDismissModalVC() {
        self.deleteAndDismissed?()
        dismiss(animated: true)
    }
}
