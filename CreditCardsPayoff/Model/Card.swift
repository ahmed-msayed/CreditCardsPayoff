//
//  Card.swift
//  CreditCardsPayoff
//
//  Created by Ahmed Sayed on 15/07/2023.
//

import CoreData

@objc(Card)
class Card: NSManagedObject {
    @NSManaged var id: NSNumber!
    @NSManaged var email: String!
    @NSManaged var title: String!
    @NSManaged var bank: String!
    @NSManaged var limit: NSNumber!
    @NSManaged var deducted: NSNumber!
    @NSManaged var available: NSNumber!
    @NSManaged var expire: String!
    @NSManaged var firstFourDigits: NSNumber!
    @NSManaged var dateAdded: Date!
    @NSManaged var notes: String!
}
