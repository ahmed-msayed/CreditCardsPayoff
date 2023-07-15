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
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var limitTextField: UITextField!
    @IBOutlet weak var availableTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonClick(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)
        let newCard = Card(entity: entity!, insertInto: context)
        newCard.id = cardList.count as NSNumber
        newCard.title = titleTextField.text
        newCard.bank = bankTextField.text
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func dismissModalVC() {
        self.isDismissed?()
        dismiss(animated: true)
    }
}
