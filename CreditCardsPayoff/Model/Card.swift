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
    @NSManaged var holder: String!
    @NSManaged var bank: String!
    @NSManaged var limit: String!
    @NSManaged var available: String!
    @NSManaged var expire: String!
    @NSManaged var number: String!
    @NSManaged var dateAdded: Date!
    @NSManaged var notes: String!
}
