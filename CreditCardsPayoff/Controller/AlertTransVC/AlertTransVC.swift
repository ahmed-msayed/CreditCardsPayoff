//
//  AlertTransVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 27/07/2023.
//

import UIKit

protocol SaveTransactionTapsDelegate: AnyObject {
    func didTapSaveTransaction()
}

class AlertTransVC: UIViewController {

    weak var delegate: SaveTransactionTapsDelegate?
    var selectedCard: Card? = nil

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
        if let limit = Double(selectedCard?.limit ?? ""), let available = Double(selectedCard?.available ?? "") {
        cardLimitLabel.text = "\(limit.formatted())"
        availableAmountLabel.text = "\(available.formatted())"

            let due = limit - available
            dueAmountLabel.text = "\(due.formatted())"
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        delegate?.didTapSaveTransaction()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
