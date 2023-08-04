//
//  TermsVC.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 02/08/2023.
//

import UIKit

class TermsVC: UIViewController {
    
    var attrText = ""
    
    @IBOutlet weak var termsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHTML()
        termsTextView.attributedText = attrText.htmlToAttributedString
    }

    private func getHTML() {
         var html = ""
        if let  htmlFile = Bundle.main.path(forResource: "TermsAndConditions", ofType: "html"){
             do {
                 html = try String(contentsOfFile: htmlFile, encoding: String.Encoding(rawValue: NSUTF8StringEncoding))
             } catch  {
                 print("Unable to get the file.")
             }
         }
        attrText = html
     }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
