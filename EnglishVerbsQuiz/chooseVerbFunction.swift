//
//  chooseVerbFunction.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2016-10-21.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import Foundation
import UIKit

class toChooseVerb {
enum TempsDeVerbe: String {
    case Present
    case Preterite
    case PresentPerfect
    case PastPerfect
    case PresentContinuous
    case PastContinuous
    case PastPerfectContinuous
    case FuturContinuous
    case PresentPerfectContinuous
    case FuturPerfectContinuous
    case Futur
    case FuturPerfect
    case Imperative
}
var hint: String = ""
var first: String = ""
var second: String = ""
var third: String = ""
var fourth: String = ""
var fifth: String = ""
var sixth: String = ""
var verbArray: NSArray = []
var indexChoice: Int = 0
var tempsChoisi: String = ""


    func chooseVerb (temps: String, indexChoice: Int, verbArray: NSArray) -> [String]{
let choixVerbe = AllVerbs(allVerbs: verbArray as! Array<[String]>, n: indexChoice)
    
    tempsChoisi = temps.replacingOccurrences(of: " ", with: "")

    if let tempsDeVerbe = TempsDeVerbe(rawValue: tempsChoisi){
        switch tempsDeVerbe {
        case .Futur:
            let verbeFinal = Futur(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .FuturContinuous:
            let verbeFinal = FuturContinuous(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .FuturPerfect:
            let verbeFinal = FuturPerfect(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .FuturPerfectContinuous:
            let verbeFinal = FuturPerfectContinuous(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .Imperative:
            let verbeFinal = Imperative(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            second = verbeFinal.second
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
        case .PastContinuous:
            let verbeFinal = PastContinuous(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .PastPerfect:
            let verbeFinal = PastPerfect(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .PastPerfectContinuous:
            let verbeFinal = PastPerfectContinuous(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .Present:
            let verbeFinal = Present(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .PresentContinuous:
            let verbeFinal = PresentContinuous(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .Preterite:
            let verbeFinal = Preterite(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .PresentPerfectContinuous:
            let verbeFinal = PresentPerfectContinuous(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        case .PresentPerfect:
            let verbeFinal = PresentPerfect(allVerbs: choixVerbe)
            hint = verbeFinal.hint
            first = verbeFinal.first
            second = verbeFinal.second
            third = verbeFinal.third
            fourth = verbeFinal.fourth
            fifth = verbeFinal.fifth
            sixth = verbeFinal.sixth
        }
    }
        return [first, second, third, fourth, fifth, sixth, hint]
}
}
