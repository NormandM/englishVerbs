//
//  DataStructure.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 16-09-17.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import Foundation
struct AllVerbs {
    let base: String
    let past: String
    let participle: String
    let thirdPerson: String
    let ingForm: String
    init(allVerbs: NSArray, n: Int){
        base = allVerbs[n][0] as! String
        past = allVerbs[n][1] as! String
        participle = allVerbs[n][2] as! String
        thirdPerson = allVerbs[n][3] as! String
        ingForm = allVerbs[n][4] as! String
    }
}
struct Present {
    let allVerbs: AllVerbs
    var first: String{return  allVerbs.base}
    var second: String{return allVerbs.base}
    var third: String{return  allVerbs.thirdPerson}
    var fourth: String{return allVerbs.base}
    var fifth: String{return  allVerbs.base}
    var sixth: String{return  allVerbs.base}
}
struct Preterite {
    let allVerbs: AllVerbs
    var first: String{return allVerbs.past}
    var second: String{return allVerbs.past}
    var third: String{return allVerbs.past}
    var fourth: String{return allVerbs.past}
    var fifth: String{return allVerbs.past}
    var sixth: String{return allVerbs.past}
    }
struct PresentPerfect {
    let allVerbs: AllVerbs
    var first: String{return "have \(allVerbs.participle)"}
    var second: String{return "have \(allVerbs.participle)"}
    var third: String{return "has \(allVerbs.participle)"}
    var fourth: String{return "have \(allVerbs.participle)"}
    var fifth: String{return "have \(allVerbs.participle)"}
    var sixth: String{return "have \(allVerbs.participle)"}
}
struct PastPerfect{
    let allVerbs: AllVerbs
    var first: String{return "had \(allVerbs.participle)"}
    var second: String{return "had \(allVerbs.participle)"}
    var third: String{return "had \(allVerbs.participle)"}
    var fourth: String{return "had \(allVerbs.participle)"}
    var fifth: String{return "had \(allVerbs.participle)"}
    var sixth: String{return "had \(allVerbs.participle)"}
    
}

struct PresentContinuous {
    let allVerbs: AllVerbs
    var first: String{return "am \(allVerbs.ingForm)"}
    var second: String{return "are \(allVerbs.ingForm)"}
    var third: String{return "is \(allVerbs.ingForm)"}
    var fourth: String{return "are \(allVerbs.ingForm)"}
    var fifth: String{return "are \(allVerbs.ingForm)"}
    var sixth: String{return "are \(allVerbs.ingForm)"}
}

struct PastContinuous{
    let allVerbs: AllVerbs
    var first: String{return "was \(allVerbs.ingForm)"}
    var second: String{return "were \(allVerbs.ingForm)"}
    var third: String{return "was \(allVerbs.ingForm)"}
    var fourth: String{return "were \(allVerbs.ingForm)"}
    var fifth: String{return "were \(allVerbs.ingForm)"}
    var sixth: String{return "were \(allVerbs.ingForm)"}
}
struct PastPerfectContinuous {
    let allVerbs: AllVerbs
    var first: String{return "had been \(allVerbs.ingForm)"}
    var second: String{return "had been \(allVerbs.ingForm)"}
    var third: String{return "had been \(allVerbs.ingForm)"}
    var fourth: String{return "had been \(allVerbs.ingForm)"}
    var fifth: String{return "had been \(allVerbs.ingForm)"}
    var sixth: String{return "had been \(allVerbs.ingForm)"}
}
struct FuturContinuous{
    let allVerbs: AllVerbs
    var first: String{return "will be \(allVerbs.ingForm)"}
    var second: String{return "will be \(allVerbs.ingForm)"}
    var third: String{return "will be \(allVerbs.ingForm)"}
    var fourth: String{return "will be \(allVerbs.ingForm)"}
    var fifth: String{return "will be \(allVerbs.ingForm)"}
    var sixth: String{return "will be \(allVerbs.ingForm)"}
}
struct PresentPerfectContinuous{
    let allVerbs: AllVerbs
    var first: String{return "have been \(allVerbs.ingForm)"}
    var second: String{return "have been \(allVerbs.ingForm)"}
    var third: String{return "has been \(allVerbs.ingForm)"}
    var fourth: String{return "have been \(allVerbs.ingForm)"}
    var fifth: String{return "have been \(allVerbs.ingForm)"}
    var sixth: String{return "have been \(allVerbs.ingForm)"}
    
}
struct FuturPerfectContinuous{
    let allVerbs: AllVerbs
    var first: String{return "will have been \(allVerbs.ingForm)"}
    var second: String{return "will have been \(allVerbs.ingForm)"}
    var third: String{return "will have been \(allVerbs.ingForm)"}
    var fourth: String{return "will have been \(allVerbs.ingForm)"}
    var fifth: String{return "will have been \(allVerbs.ingForm)"}
    var sixth: String{return "will have been \(allVerbs.ingForm)"}
    
}
struct Futur{
    let allVerbs: AllVerbs
    var first: String{return "will \(allVerbs.base)"}
    var second: String{return "will \(allVerbs.base)"}
    var third: String{return "will \(allVerbs.base)"}
    var fourth: String{return "will \(allVerbs.base)"}
    var fifth: String{return "will \(allVerbs.base)"}
    var sixth: String{return "will \(allVerbs.base)"}
}
struct FuturPerfect{
    let allVerbs: AllVerbs
    var first: String{return "will have \(allVerbs.past)"}
    var second: String{return "will have \(allVerbs.past)"}
    var third: String{return "will have \(allVerbs.past)"}
    var fourth: String{return "will have \(allVerbs.past)"}
    var fifth: String{return "will have \(allVerbs.past)"}
    var sixth: String{return "will have \(allVerbs.past)"}
}
struct Infinitive{
    let allVerbs: AllVerbs
    var first: String {return "to \(allVerbs.base)"}
}
struct Imperative{
    let allVerbs: AllVerbs
    var second: String{return allVerbs.base}
    var third: String{return allVerbs.base}
    var fourth: String{return allVerbs.base}
}











