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
//        self.showSpinner(onView: self.view)
        initializeTableView()
//        ProfileVM.getProfile() {user,error in
//            self.removeSpinner()
//            self.tableView.reloadData()
//        }
    }
    
    func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProfileHeaderCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderCell")
        tableView.register(UINib(nibName: "AccountSettingsCell", bundle: nil), forCellReuseIdentifier: "AccountSettingsCell")
        tableView.register(UINib(nibName: "AppSettingsCell", bundle: nil), forCellReuseIdentifier: "AppSettingsCell")
        tableView.register(UINib(nibName: "TermsConditionsCell", bundle: nil), forCellReuseIdentifier: "TermsConditionsCell")
        self.tableView.reloadData()
    }

}

// MARK: - UITableView
extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
            return 316
        case 2:
            return 180
        case 3:
            return 90
        default:
            return 90
        }
    }
}

// MARK: - ProfileDelegates
extension SettingsVC: ProfileHeaderTapsDelegate, AccountSettingsTapsDelegate, AppSettingsTapsDelegate, TermsConditionsTapsDelegate {

    func didTapEdit() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeNameVC") as? ChangeNameVC {
            let sheetController = SheetViewController(controller: viewController, sizes: [.fixed(420)])
            sheetController.cornerRadius = 35
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
//        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrencyVC") as? CurrencyVC {
//            self.navigationController?.pushViewController(viewController, animated: true)
//            navigationItem.backBarButtonItem = UIBarButtonItem(
//                title: "Change Currency".localized(), style: .plain, target: nil, action: nil)
//            navigationItem.backBarButtonItem?.tintColor = .white
//        }
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
//        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeEmailVC") as? ChangeEmailVC {
//            self.navigationController?.pushViewController(viewController, animated: true)
//            navigationItem.backBarButtonItem = UIBarButtonItem(
//                title: "Change Email".localized(), style: .plain, target: nil, action: nil)
//            navigationItem.backBarButtonItem?.tintColor = .white
//        }
    }
    
    func didTapChangePassword() {
//        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordVC {
//            self.navigationController?.pushViewController(viewController, animated: true)
//            navigationItem.backBarButtonItem = UIBarButtonItem(
//                title: "Change Password".localized(), style: .plain, target: nil, action: nil)
//            navigationItem.backBarButtonItem?.tintColor = .white
//        }
    }
    
    func didTapTerms() {
//        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsVC") as? TermsVC {
//            self.navigationController?.pushViewController(viewController, animated: true)
//            navigationItem.backBarButtonItem = UIBarButtonItem(
//                title: "Terms & Conditions".localized(), style: .plain, target: nil, action: nil)
//            navigationItem.backBarButtonItem?.tintColor = .white
//        }
    }
}
