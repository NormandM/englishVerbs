//
//  ModeAndTempStruct.swift
//  VerbAppRefactored
//
//  Created by Normand Martin on 2019-02-04.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct ModeAndTemp {
    let pattern: [[String]] = [
    ["I, You, We, They: infinitive", "He, She, It: infinitive + s", "Example affirmative: I walk, He walks", "Example negative: I don't walk, He doesn't walk", "Example interrogative: Do I walk?, Does he walk?"],
    ["I, You, We, They, He, She, It: infinitive + ed", "Example affirmative: I walked, He walked", "Example negative: I didn't walk, He doesn't walk", "Example interrogative: Did I walk?, Did he walk?"],
    ["I, You, We, They: have + infinitive + ed", "He, She, It: has infinitive + ed","Example affirmative: I have walked, He has walked", "Example negative: I haven't walk, He hasn’t walk", "Example interrogative: Have I walked?, Has he walked?"],
    ["I, You, We, They, He, She, It: had walked","Example affirmative: I had walked, He had walked", "Example negative: I hadn't walked, He hadn't walked", "Example interrogative: Had I walked?, Had he walked?"],
    ["I: infinitive + ing", "You, We, They: are + infinitive + ing", "He, She, It: is + infinitive + ing", "Example affirmative: I am walking, He is walking", "Example negative: I'm not walking, He isn't walking", "Example interrogative: Am I walking?, Is he walking?"],
    ["I, He, She, It: was + infinitive + ing", "You, We, They: were + infinitive + ing", "Example affirmative: I was walking, He was walking", "Example negative: I wasn't walking, He wasn't walking", "Example interrogative: Was I walking?, Was he walking?"],
    ["I, You, We, They, He, She, It: had been + infinitive + ing", "Example affirmative: I had been walking, He had been walking", "Example negative: I hadn't been walking, He hadn't been walking", "Example interrogative: Had I been walking?, Had he been walking?"],
    ["I, You, We, They, He, She, It: will be + infinitive + ing", "Example affirmative: I will be walking, He will be walking", "Example negative: I won't be walking, He won't be walking", "Example interrogative: Will I be walking?, Will he bewalking?"],
    ["I, You, We, They: have been + infinitive + ing", "He, She, It: has been + infinitive + ing", "Example affirmative: I have been walking, He has been walking", "Example negative: I haven't been walking, He hasn't been walking", "Example interrogative: Have I been walking?, Has he been bewalking?"],
    ["I, You, We, They, He, She, It: will have been + infinitive + ing", "Example affirmative: I will have been walking, He will have been walking", "Example negative: I won't have been walking, He won't have been walking", "Example interrogative: Will I have been walking?, Will he have been bewalking?"],
    ["I, You, We, They, He, She, It: will + infinitive", "Example affirmative: I will walk, He will walk", "Example negative: I won't walk, He won't walk", "Example interrogative: Will I walk?, Will he walk?"],
    ["I, You, We, They, He, She, It: will have + past participle", "Example affirmative:  I will have walked, He will have walked", "Example negative: I won't have walked, He won't have walked", "Example interrogative: Will I have walked?, Will he have walked?"],
    ["(You): infinitive", "(We): let's + infinitive, (You) walk, let's walk"],
    ["I, You, We, They, He, She, It: would + infinitive", "Example affirmative:  I would walk, He would walk", "Example negative: I wouldn't walk, He wouldn't  walk", "Example interrogative: Would I walk?, Would he have walk?"],
    ["I, You, We, They, He, She, It: would + be + infinitive + ing", "Example affirmative:  I would be walking, He would be walking", "Example negative: I wouldn't be walking, He wouldn't be walking", "Example interrogative: Would I be walking?, Would he be walking?"],
    ["I, You, We, They, He, She, It: would + have + past participle", "Example affirmative:  I would have walked, He would have walked", "Example negative: I wouldn't have walked, He wouldn't  have walked", "Example interrogative: Would I have walked?, Would he have have walked?"],
    ["I, You, We, They, He, She, It: would + have + been + infinitive + ing", "Example affirmative:  I would have been walking, He would have been walking", "Example negative: I wouldn't have been walking, He wouldn't have been walking", "Example interrogative: Would I have been walking?, Would he have been walking?"]]
    let temp: [String] = ["Simple Present", "Simple Past", "Simple Present Perfect", "Simple Past Perfect", "Present Progressive", "Past Progressive", "Past Perfect Progressive", "Futur Progressive", "Present Perfect Progressive", "Futur Perfect Progressive", "Futur", "Futur Perfect Simple", "Imperative", "Conditional Simple", "Conditional Progressive", "Conditional Perfect", "Conditional Perfect Progressive"]
    var typeOfVerbs = [VerbForm.auxiliaryBe.rawValue, VerbForm.auxiliaryHave.rawValue, VerbForm.regularVerb.rawValue, VerbForm.irregularVerb.rawValue]
    var infinitivePicker = ["be", "have", "walk", "do"]
    func choice(position1: Int, position2: Int) -> (String, String, String){
        let tempChosen = temp[position1]
        let formChosen = typeOfVerbs[position2]
        let infinitiveChosen = infinitivePicker[position2]
        return(tempChosen, formChosen, infinitiveChosen)
    }
    func pickerChoice(row: Int, component: Int) -> (String, String){
        var verbForm = String()
        var infinitive = String()
        switch  typeOfVerbs[row]{
            case VerbForm.auxiliaryBe.rawValue:
                verbForm = "To Be"
                infinitive = "be"
            case VerbForm.auxiliaryHave.rawValue:
                verbForm = "To Have"
                infinitive = "have"
            case VerbForm.regularVerb.rawValue:
                verbForm = "To Walk"
                infinitive = "walk"
            case VerbForm.irregularVerb.rawValue:
                verbForm = "To Do"
                infinitive = "do"
            default:
                break
        }
        
        return (verbForm, infinitive)
    }
}

enum VerbForm: String {
    case regularVerb = "Regular Verb: to walk"
    case auxiliaryBe = "Auxiliary Verb: To Be"
    case auxiliaryHave = "Auxiliary Verb: to have"
    case irregularVerb = "Irregular Verb: to do"
}
