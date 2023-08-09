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
var sortedCardList = [Card]()

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
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
    
    func initializeViews() {
        titleView.cornerRadius = 15
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
        tableView.clipsToBounds = true
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
    }
    
    func getCardsData() {
        cardList = []
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
            self.cardListDateSorted()
        }
        catch
        {
            self.showAlert(message: "Getting Data Failed", type: false)
        }
    }
    
    func cardListDateSorted() {
        sortedCardList = cardList.sorted {
            $0.dateAdded > $1.dateAdded
        }
        cardList = sortedCardList
        self.tableView.reloadData()
    }
    
    func initializeNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTableView), name: NSNotification.Name(rawValue: "updateTableView"), object: nil)
    }
    
    @objc func updateTableView() {
        DispatchQueue.main.async {
            self.cardListDateSorted()
            self.tableView.reloadData()
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
        cell.selectionStyle = .none
        
        let currency = CurrencyVM.getLocalUserCurrency()?.currencyCode ?? ""
        let thisCard: Card
        thisCard = cardList[indexPath.row]
        cell.updateViews(card: thisCard, currency: currency)
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
    
    //Cell Animation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.7, delay: 0.1 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }
    
    //Swipe Actions
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let depositAction = UIContextualAction(style: .normal,
                                               title: "Deposit") { [weak self] (depositAction, view, completionHandler) in
            let selectedCard: Card
            selectedCard = cardList[indexPath.row]
            self?.swipeLefttAction(selectedCard: selectedCard)
            completionHandler(true)
        }
        depositAction.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [depositAction])
    }
    
    func swipeLefttAction(selectedCard: Card) {
        let alertAskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertTransVC") as! AlertTransVC
        alertAskVC.selectedCard = selectedCard
        alertAskVC.transType = true
        alertAskVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertAskVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        alertAskVC.depositAndDismissed = { [weak self] in
            self?.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self?.showAlert(message: "Card Updated successfully!", type: true)
            }
        }
        self.present(alertAskVC, animated: true)
        alertAskVC.initializeData(title: "Deposit Amount", amountTitle: "Deposit Amount")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let withdrawAction = UIContextualAction(style: .normal,
                                                title: "Withdraw") { [weak self] (withdrawAction, view, completionHandler) in
            let selectedCard: Card
            selectedCard = cardList[indexPath.row]
            self?.swipeRightAction(selectedCard: selectedCard)
            completionHandler(true)
        }
        withdrawAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [withdrawAction])
    }
    
    func swipeRightAction(selectedCard: Card) {
        let alertAskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertTransVC") as! AlertTransVC
        alertAskVC.selectedCard = selectedCard
        alertAskVC.transType = false
        alertAskVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertAskVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        alertAskVC.depositAndDismissed = { [weak self] in
            self?.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self?.showAlert(message: "Card Updated successfully!", type: true)
            }
        }
        self.present(alertAskVC, animated: true)
        alertAskVC.initializeData(title: "Withdraw Amount", amountTitle: "Withdraw Amount")
    }
}
