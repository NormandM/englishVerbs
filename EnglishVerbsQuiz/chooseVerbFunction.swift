//
//  chooseVerbFunction.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2016-10-21.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import Foundation
import UIKit

class ToChooseVerb {
    enum TempsDeVerbe: String {
        case SimplePresent
        case SimplePast
        case SimplePresentPerfect
        case SimplePastPerfect
        case PresentProgressive
        case PastProgressive
        case PastPerfectProgressive
        case FuturProgressive
        case PresentPerfectProgressive
        case FuturPerfectProgressive
        case Futur
        case FuturPerfectSimple
        case Imperative
        case ConditionalSimple
        case ConditionalProgressive
        case ConditionalPerfect
        case ConditionalPerfectProgressive
    }
    var hint: String = ""
    var first: String = ""
    var second: String = ""
    var third: String = ""
    var fourth: String = ""
    var fifth: String = ""
    var sixth: String = ""
    var verbArray = [[String]]()
    var indexChoice: Int = 0
    var tempsChoisi: String = ""
    
    func chooseVerb (temps: String, indexChoice: Int, verbArray: [[String]]) -> [String]{
        let choixVerbe = AllVerbs(allVerbs: verbArray , n: indexChoice)
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
            case .FuturProgressive:
                let verbeFinal = FuturContinuous(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .FuturPerfectSimple:
                let verbeFinal = FuturPerfect(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .FuturPerfectProgressive:
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
            case .PastProgressive:
                let verbeFinal = PastContinuous(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .SimplePastPerfect:
                let verbeFinal = PastPerfect(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .PastPerfectProgressive:
                let verbeFinal = PastPerfectContinuous(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .SimplePresent:
                let verbeFinal = Present(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .PresentProgressive:
                let verbeFinal = PresentContinuous(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .SimplePast:
                let verbeFinal = Preterite(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .PresentPerfectProgressive:
                let verbeFinal = PresentPerfectContinuous(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .SimplePresentPerfect:
                let verbeFinal = PresentPerfect(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .ConditionalSimple:
                let verbeFinal = ConditionalSimple(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .ConditionalPerfect:
                let verbeFinal = ConditionalPerfect(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .ConditionalProgressive:
                let verbeFinal = ConditionalProgressive(allVerbs: choixVerbe)
                hint = verbeFinal.hint
                first = verbeFinal.first
                second = verbeFinal.second
                third = verbeFinal.third
                fourth = verbeFinal.fourth
                fifth = verbeFinal.fifth
                sixth = verbeFinal.sixth
            case .ConditionalPerfectProgressive:
                let verbeFinal = ConditionalPerfectProgressive(allVerbs: choixVerbe)
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

