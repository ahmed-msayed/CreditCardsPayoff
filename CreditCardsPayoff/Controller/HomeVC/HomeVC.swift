//
//  HomeVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 23/06/2023.
//

import UIKit
import FittedSheets
import CoreData

var cardList = [Card]()

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var firstLoad = true
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (firstLoad) {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
            do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results
            {
            let card = result as! Card
            cardList.append(card)
            }
            }
            catch
            {
                print("fetch failed")
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = UserVM.getLocalUser() else {return}
        self.welcomeLabel.text = "\(user.firstName)"+" "+"\(user.lastName)"+" "+"\(user.email)"
    }
    
    func getUserData() {
        let userId = AuthenticationVM.getCurrentUserId()
        AuthenticationVM.getUserDataFromDB(userId: userId) { userVM, error in
            if let userVM = userVM {
                userVM.saveUserLocally()
            } else {
                self.showAlert(message: error ?? "Unknown Error", type: false)
            }
        }
    }
    
    @IBAction func addCardButtonClick(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCardVC") as? AddCardVC {
            let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(650)])
            sheetController.cornerRadius = 35
            
            viewController.isDismissed = { [weak self] in
                self?.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self?.showAlert(message: "Card Added successfully!", type: true)
                }
            }
            self.present(sheetController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell

        let thisCard: Card
        thisCard = cardList[indexPath.row]
        
        cell.titleLabel.text = thisCard.title
        cell.bankLabel.text = thisCard.bank
        cell.availableLabel.text = "\(thisCard.available ?? 0)"
        
        return cell
    }
    
//    @IBAction func clearUserDefaultsBtn(_ sender: Any) {
//        UserVM.removeLocalUser()
//        UserDefaults.standard.synchronize()
//        welcomeLabel.text = "\(UserVM.getLocalUser()?.firstName ?? "")"+" "+"\(UserVM.getLocalUser()?.lastName ?? "")"
//    }
}
