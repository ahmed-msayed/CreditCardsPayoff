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
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        initializeTableView()
        initializeNotificationCenter()
        getCardsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = UserVM.getLocalUser() else {return}
        self.welcomeLabel.text = "Welcome \(user.firstName) \(user.lastName)"
    }
    
    func getUserData() {
        // to reload data if it is changed from another logged device
        let userId = AuthenticationVM.getCurrentUserId()
        AuthenticationVM.getUserDataFromDB(userId: userId) { userVM, error in
            if let userVM = userVM {
                userVM.saveUserLocally()
            } else {
                self.showAlert(message: error ?? "Unknown Error", type: false)
            }
        }
    }
    
    func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
    }
    
    func initializeNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTableView), name: NSNotification.Name(rawValue: "updateTableView"), object: nil)
    }
    
    @objc func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getCardsData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        // filtering fetched data
        guard let user = UserVM.getLocalUser() else {return}
        let filter = user.email
        let predicate = NSPredicate(format: "email = %@", filter)
        request.predicate = predicate
        //
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let card = result as! Card
                cardList.append(card)
            }
            self.tableView.reloadData()
        }
        catch
        {
            self.showAlert(message: "Getting Data Failed", type: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        
        let thisCard: Card
        thisCard = cardList[indexPath.row]
        cell.updateViews(card: thisCard)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditCardVC") as? EditCardVC {
            
            let selectedCard: Card
            selectedCard = cardList[indexPath.row]
            viewController.selectedCard = selectedCard
            tableView.deselectRow(at: indexPath, animated: true)
            
            let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(750)])
            sheetController.cornerRadius = 35
            
            viewController.deleteAndDismissed = { [weak self] in
                // remove the deleted item from the model and List
                let appDel = UIApplication.shared.delegate as! AppDelegate
                let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
                context.delete(cardList[indexPath.row])
                cardList.remove(at: (indexPath.row))
                do {
                    try context.save()
                } catch _ {
                }
                
                self?.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self?.showAlert(message: "Card Deleted successfully!", type: true)
                }
            }
            
            viewController.saveAndDismissed = { [weak self] in
                self?.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self?.showAlert(message: "Card Saved successfully!", type: true)
                }
            }
            self.present(sheetController, animated: true, completion: nil)
        }
    }
}
