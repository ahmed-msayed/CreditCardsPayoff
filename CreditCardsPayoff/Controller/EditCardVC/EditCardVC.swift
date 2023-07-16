//
//  EditCardVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 16/07/2023.
//

import UIKit
import CoreData

class EditCardVC: UIViewController {
    
    var isDismissed: (() -> Void)?
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
        cardLimitTextField.text = selectedCard?.limit
        availableAmountTextField.text = selectedCard?.available
        notesTextView.text = selectedCard?.notes
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
                    card.limit = cardLimitTextField.text
                    card.available = availableAmountTextField.text
                    card.notes = notesTextView.text
                    try context.save()
                    dismissModalVC()
                }
            }
        }
        catch
        {
            self.showAlert(message: "Getting Data Failed", type: false)
        }
    }
    
    func dismissModalVC() {
        self.isDismissed?()
        dismiss(animated: true)
    }
}
