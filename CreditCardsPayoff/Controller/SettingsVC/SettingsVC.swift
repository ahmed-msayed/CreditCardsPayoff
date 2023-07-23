//
//  SettingsVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 23/06/2023.
//

import UIKit
import FittedSheets

class SettingsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeTableView()
    }
    
    func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProfileHeaderCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderCell")
        tableView.register(UINib(nibName: "AccountSettingsCell", bundle: nil), forCellReuseIdentifier: "AccountSettingsCell")
        tableView.register(UINib(nibName: "AppSettingsCell", bundle: nil), forCellReuseIdentifier: "AppSettingsCell")
        tableView.register(UINib(nibName: "TermsConditionsCell", bundle: nil), forCellReuseIdentifier: "TermsConditionsCell")
        tableView.register(UINib(nibName: "LogoutCell", bundle: nil), forCellReuseIdentifier: "LogoutCell")
        self.tableView.reloadData()
    }
}

// MARK: - UITableView
extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 :
            return ""
        case 1 :
            return "App Settings"
        case 2:
            return "Account Settings"
        case 3:
            return "Terms & Conditions"
        case 4:
            return "LogOut"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderCell", for: indexPath) as! ProfileHeaderCell
            cell.delegate = self
            cell.bindData()
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSettingsCell", for: indexPath) as! AccountSettingsCell
            cell.delegate = self
            cell.bindData()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppSettingsCell", for: indexPath) as! AppSettingsCell
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TermsConditionsCell", for: indexPath) as! TermsConditionsCell
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell", for: indexPath) as! LogoutCell
            cell.delegate = self
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return 90
        case 1 :
            return 240
        case 2:
            return 120
        case 3:
            return 60
        case 4:
            return 60
        default:
            return 90
        }
    }
}

// MARK: - ProfileDelegates
extension SettingsVC: ProfileHeaderTapsDelegate, AccountSettingsTapsDelegate, AppSettingsTapsDelegate, TermsConditionsTapsDelegate, LogoutTapsDelegate {
    
    func didTapEdit() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeNameVC") as? ChangeNameVC {
            let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(550)])
            sheetController.cornerRadius = 35
            
            viewController.isDismissed = { [weak self] in
                self?.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self?.showAlert(message: "Name changed successfully!", type: true)
                }
            }
            self.present(sheetController, animated: true, completion: nil)
        }
    }
    
    func didTapLanguage() {
        //        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LanguageVC") as? LanguageVC {
        //            self.navigationController?.pushViewController(viewController, animated: true)
        //            navigationItem.backBarButtonItem = UIBarButtonItem(
        //                title: "Change Language".localized(), style: .plain, target: nil, action: nil)
        //            navigationItem.backBarButtonItem?.tintColor = .white
        //        }
    }
    
    func didTapCurrency() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrencyVC") as? CurrencyVC {
            let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(550)])
            sheetController.cornerRadius = 35
            
            viewController.isDismissed = { [weak self] in
                self?.tableView.reloadData()
            }
            self.present(sheetController, animated: true, completion: nil)
        }
    }
    
    func didChangeModeToDark() {
        //        DMTraitCollection.setOverride(DMTraitCollection(userInterfaceStyle: .dark), animated: true)
        //        Helper.shared.interfaceMode = "dark"
        //        initializeView()
    }
    
    func didChangeModeToLight() {
        //        DMTraitCollection.setOverride(DMTraitCollection(userInterfaceStyle: .light), animated: true)
        //        Helper.shared.interfaceMode = "light"
        //        initializeView()
    }
    
    func didTapChangeEmail() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeEmailVC") as? ChangeEmailVC {
            let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(620)])
            sheetController.cornerRadius = 35
            
            viewController.isDismissed = { [weak self] in
                self?.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self?.showAlert(message: "Email changed successfully!", type: true)
                }
            }
            self.present(sheetController, animated: true, completion: nil)
        }
    }
    
    func didTapChangePassword() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordVC {
            let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(620)])
            sheetController.cornerRadius = 35
            
            viewController.isDismissed = { [weak self] in
                self?.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self?.showAlert(message: "Password changed successfully!", type: true)
                }
            }
            self.present(sheetController, animated: true, completion: nil)
        }
    }
    
    func didTapTerms() {
        //        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsVC") as? TermsVC {
        //            self.navigationController?.pushViewController(viewController, animated: true)
        //            navigationItem.backBarButtonItem = UIBarButtonItem(
        //                title: "Terms & Conditions".localized(), style: .plain, target: nil, action: nil)
        //            navigationItem.backBarButtonItem?.tintColor = .white
        //        }
    }
    
    func didTapLogout() {
        let alertAskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertAskVC") as! AlertAskVC
        alertAskVC.alertMessage = "Are you sure you want's to logout?"
        alertAskVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertAskVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertAskVC, animated: true)
    }
}
