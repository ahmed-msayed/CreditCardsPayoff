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
        clearDatabase()
        getUserData()
        initializeTableView()
        getCardsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = UserVM.getLocalUser() else {return}
        self.welcomeLabel.text = "Welcome \(user.firstName) \(user.lastName)"
    }
    
    public func clearDatabase() {
        
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
    
    func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
    }
    
    func getCardsData() {
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
                self.showAlert(message: "Getting Data Failed", type: false)
            }
        }
    }
    
    @IBAction func addCardButtonClick(_ sender: Any) {
        //        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCardVC") as? AddCardVC {
        //            let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(650)])
        //            sheetController.cornerRadius = 35
        //
        //            viewController.isDismissed = { [weak self] in
        //                self?.tableView.reloadData()
        //                DispatchQueue.main.asyncAfter(deadline: .now()) {
        //                    self?.showAlert(message: "Card Added successfully!", type: true)
        //                }
        //            }
        //            self.present(sheetController, animated: true, completion: nil)
        //        }
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCardVC") as? AddCardVC {
            let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(750)])
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
        if let limit = Double(thisCard.limit), let available = Double(thisCard.available) {
            cell.dueLabel.text = "\(limit - available)"
        }
        cell.availableLabel.text = thisCard.available
        cell.firstFourDigitsLabel.text = "\(thisCard.number.suffix(4))"
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
            
            viewController.isDismissed = { [weak self] in
                self?.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self?.showAlert(message: "Card Saved successfully!", type: true)
                }
            }
            self.present(sheetController, animated: true, completion: nil)
        }
    }
    
    //    @IBAction func clearUserDefaultsBtn(_ sender: Any) {
    //        UserVM.removeLocalUser()
    //        UserDefaults.standard.synchronize()
    //        welcomeLabel.text = "\(UserVM.getLocalUser()?.firstName ?? "")"+" "+"\(UserVM.getLocalUser()?.lastName ?? "")"
    //    }
}
