//
//  ChoixDeLaPersonne.swift
//  VerbAppRefactored
//
//  Created by Normand Martin on 2019-02-10.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct ChoixDuPronom {
    let personne: String
    let pronom: String
    init(personne: String, temp: String) {
        self.personne = personne
        var pronomTrans = String()
        if temp != "Imperative"{
            switch personne {
            case "1":
                pronomTrans = "I"
            case "2":
                pronomTrans = "you"
            case "3":
                pronomTrans = "he/she/it"
            case "4":
                pronomTrans = "we"
            case "5":
                pronomTrans = "you"
            case "6":
                pronomTrans = "they"
            default:
                break
            }
        }else{
            switch personne {
            case "1":
                pronomTrans = ""
            case "2":
                pronomTrans = "(you)"
            case "3":
                pronomTrans = ""
            case "4":
                pronomTrans = "(we)"
            case "5":
                pronomTrans = "(you)"
            case "6":
                pronomTrans = ""
            default:
                break
            }
            
        }
      pronom = pronomTrans
    }
}
    
    

