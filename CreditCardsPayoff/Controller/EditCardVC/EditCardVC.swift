//
//  EditCardVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 16/07/2023.
//

import UIKit
import CoreData

class EditCardVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var saveAndDismissed: (() -> Void)?
    var deleteAndDismissed: (() -> Void)?
    var selectedCard: Card? = nil
    let datePicker = UIDatePicker()
    
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
        setTextFieldsDelegate()
        loadData()
        setDatePicker()
    }
    
    func setTextFieldsDelegate() {
        cardNumberTextField.delegate = self
        cardLimitTextField.delegate = self
        availableAmountTextField.delegate = self
        expiryDateTextField.delegate = self
        bankNameTextField.delegate = self
        holderNameTextField.delegate = self
        cardTitleTextField.delegate = self
        notesTextView.delegate = self
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let isNumber = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        let withDecimal = ( string == NumberFormatter().decimalSeparator &&
            textField.text?.contains(string) == false )
        let maxLength : Int
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        switch textField {
        case cardNumberTextField:
            maxLength = 16
            return isNumber && newString.length <= maxLength
        case bankNameTextField:
            maxLength = 30
            return newString.length <= maxLength
        case holderNameTextField:
            maxLength = 30
            return newString.length <= maxLength
        case expiryDateTextField:
            return false
        case cardTitleTextField:
            maxLength = 40
            return newString.length <= maxLength
        case cardLimitTextField:
            maxLength = 15
            return (isNumber || withDecimal) && newString.length <= maxLength
        case availableAmountTextField:
            maxLength = 15
            return (isNumber || withDecimal) && newString.length <= maxLength
        default:
            return true
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars <= 100
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
    
    // MARK: - Expiry Date Picker
    func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        expiryDateTextField.inputAccessoryView = toolbar
        expiryDateTextField.inputView = datePicker
    }
    
    @objc func doneDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        expiryDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
}
