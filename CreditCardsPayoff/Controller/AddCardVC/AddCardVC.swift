//
//  AddCardVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 15/07/2023.
//

import UIKit
import CoreData

class AddCardView: UIViewController {

    var isDismissed: (() -> Void)?

	@IBOutlet var viewCardBackground: UIView!
	@IBOutlet var labelName: UITextField!
	@IBOutlet var viewCard: UIView!
	@IBOutlet var imageCard: UIImageView!
	@IBOutlet var labelCardNumber: UITextField!
	@IBOutlet var CVVTextField: UITextField!
	@IBOutlet var expiryDateTextField: UITextField!
	@IBOutlet var labelCardDesign: UILabel!
	@IBOutlet var textFieldCardHolder: UITextField!
	@IBOutlet var textFieldCardNumber: UITextField!
	@IBOutlet var textFieldExpDate: UITextField!
	@IBOutlet var textFieldCVV: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
        
		viewCardBackground.layer.borderWidth = 1
        viewCardBackground.layer.borderColor = UIColor.blue.cgColor
		viewCard.layer.borderWidth = 1
		viewCard.layer.borderColor = UIColor.blue.cgColor

		loadData()
	}

	func loadData() {
		labelName.text = "Dave Smith"
		labelCardNumber.text = "3742 8892 2573 3800"
		CVVTextField.text = "143"
        expiryDateTextField.text = "02/2021"
		labelCardDesign.text = "Light"

		textFieldCardHolder.text = "Dave Smith"
		textFieldCardNumber.text = "3742 8892 2573 3800"
		textFieldExpDate.text = "02/2021"
		textFieldCVV.text = "143"
	}

	// MARK: - User actions

	@IBAction func actionAddCard(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)
        let newCard = Card(entity: entity!, insertInto: context)
        newCard.id = cardList.count as NSNumber
        newCard.title = labelName.text
        newCard.bank = labelCardNumber.text
        newCard.limit = 10000
        do
        {
            try context.save()
            cardList.append(newCard)
            dismissModalVC()
        }
        catch {
            print ("context save error")
        }
	}
    
    func dismissModalVC() {
        self.isDismissed?()
        dismiss(animated: true)
    }
}
