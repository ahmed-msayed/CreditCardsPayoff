//
//  AlertTransVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 27/07/2023.
//

import UIKit
import CoreData

class AlertTransVC: UIViewController {
    
    var selectedCard: Card? = nil
    var depositAndDismissed: (() -> Void)?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var currentDataView: UIView!
    @IBOutlet weak var cardLimitLabel: UILabel!
    @IBOutlet weak var availableAmountLabel: UILabel!
    @IBOutlet weak var dueAmountLabel: UILabel!
    
    @IBOutlet weak var addAmountView: UIView!
    @IBOutlet weak var addAmountTextField: UITextField!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        loadData()
    }
    
    func initializeViews() {
        mainView.layer.cornerRadius = 21
        saveButton.layer.cornerRadius = 14
        cancelButton.layer.cornerRadius = 14
    }
    
    func loadData() {
        guard let limit = selectedCard?.limit else {return}
        guard let available = selectedCard?.available else {return}
        
        cardLimitLabel.text = "\(limit)"
        availableAmountLabel.text = "\(available)"
        
        let due = limit - available
        dueAmountLabel.text = "\(due)"
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let card = result as! Card
                if (card == selectedCard) {
                    guard let available = selectedCard?.available else {return}
                    guard let deposit = Double(addAmountTextField.text ?? "") else {return}
                    card.available = available + deposit
                    try context.save()
                    saveAndDismissAlertTransVC()
                }
            }
        }
        catch
        {
            self.showAlert(message: "Getting Data Failed", type: false)
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveAndDismissAlertTransVC() {
        self.depositAndDismissed?()
        dismiss(animated: true)
    }
}