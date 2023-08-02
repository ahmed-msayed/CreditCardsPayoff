//
//  AddCardVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 15/07/2023.
//

import UIKit
import CoreData

class AddCardVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var isDismissed: (() -> Void)?
    var cardType: CardType = .other
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
    @IBOutlet weak var addCardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        setTextFieldsDelegate()
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
    
    func initializeViews() {
        viewCardBackground.layer.borderWidth = 1
        viewCardBackground.layer.borderColor = UIColor.blue.cgColor
        viewCard.layer.borderWidth = 1
        viewCard.layer.borderColor = UIColor.blue.cgColor
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
        newCard.dateAdded = Date.now
        if cardLimitTextField.text == "" {
            newCard.limit = 0
        } else {
            guard let limit = Double(cardLimitTextField.text ?? "") else {return}
            newCard.limit = limit
        }
        if availableAmountTextField.text == "" {
            newCard.available = 0
        } else {
            guard let available = Double(availableAmountTextField.text ?? "") else {return}
            newCard.available = available
        }
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
