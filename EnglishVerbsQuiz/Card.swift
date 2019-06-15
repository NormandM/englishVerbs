//
//  Card.swift
//  IrregularVerbsTest
//
//  Created by Normand Martin on 2019-04-20.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit
struct Card {
    let cardImage: UIImage
    var cardPushed = false
    let cardVerb: String
    let cardPosition: Int
    let cardGoodAnswer: Bool
    let paintingNumber: String
}
struct CardRelation {
    let goodCard: Card
    let badCard: Card
    let infinitive: String
    let relation: (Int, Int)
    let paintingNumber: String
    init(goodCard: Card, badCard: Card, relation: (Int, Int), infinitive: String, paintingNumber: String){
        self.goodCard = goodCard
        self.badCard = badCard
        self.infinitive = infinitive
        self.relation = (goodCard.cardPosition, badCard.cardPosition)
        self.paintingNumber = paintingNumber
    }
}
