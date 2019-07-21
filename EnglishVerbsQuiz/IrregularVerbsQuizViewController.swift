//
//  IrregularVerbsQuizViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-07-11.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit
import AVFoundation


class IrregularVerbsQuizViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var irregularVerbCollectionView: UICollectionView!
    @IBOutlet var finishedQuizMessage: UIView!
    @IBOutlet weak var infinitiveLabel: UILabel!
    @IBOutlet weak var simplePastLabel: UILabel!
    @IBOutlet weak var pastParticipleLabel: UILabel!
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var seeStatistics: UIButton!
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var messageTitleLabel: UILabel!
    @IBOutlet weak var miniQuizStatisticsButton: UIButton!
    @IBOutlet weak var startOverButton: UIButton!
    @IBOutlet weak var backToMenuButton: UIButton!
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
    lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    var effect: UIVisualEffect!
    var soundPlayer: SoundPlayer?
    var verbCountForQuiz = Int()
    var irregularVerbs = [[String]]()
    var arrayForQuiz = [String]()
    var exceptionsArray = [[String]]()
    var shuffledArray = [[String]]()
    var exceptionPastParticiple = [String]()
    var exceptionSimplePast = [String]()
    var simplePast = [String]()
    var pastParticiple = [String]()
    var cellIndexPath: IndexPath = [0,0]
    var quizNumber: Int = 1
    let colorReference = ColorReference()
    let fonts =  FontsAndConstraintsOptions()
    var keiBoardHeight: CGFloat = 0
    var initialPosition: CGFloat = 0
    var titleButtonNext = String()
    var buttonString = String()
    var miniQuizGoodAnswerSimplePast = UserDefaults.standard.integer(forKey: "miniQuizGoodAnswerSimplePast")
    var miniQuizBadAnswerSimplePast = UserDefaults.standard.integer(forKey: "miniQuizBadAnswerSimplePast")
    var miniQuizGoodAnswerPastParticiple = UserDefaults.standard.integer(forKey: "miniQuizGoodAnswerPastParticiple")
    var miniQuizBadAnswerPastParticiple = UserDefaults.standard.integer(forKey: "miniQuizBadAnswerPastParticiple")
    override func viewDidLoad() {
        super.viewDidLoad()
        soundPlayer = SoundPlayer()
        if let plistPath = Bundle.main.path(forResource: "100IrregularVerbs", ofType: "plist"),
            let verbArray = NSArray(contentsOfFile: plistPath){
            exceptionsArray = verbArray as! [[String]]
        }
        if let plistPath = Bundle.main.path(forResource: "IrregularVerbsSimplified", ofType: "plist"),
            let verbArray = NSArray(contentsOfFile: plistPath){
            irregularVerbs = verbArray as! [[String]]
        }
        buttonString = """
        Ready for
        Quiz?
        """
        quizButton.layer.cornerRadius = quizButton.frame.height/2
        quizButton.titleLabel?.textAlignment = .center
        quizButton.titleLabel?.font = fonts.smallBoldFont
        quizButton.titleLabel?.numberOfLines = 0
        quizButton.backgroundColor = colorReference.specialGreen
        quizButton.titleLabel?.textColor = .white
        quizButton.setTitle(buttonString, for: .normal)
        UserDefaults.standard.set(0, forKey: "miniQuizGoodAnswerSimplePast")
        UserDefaults.standard.set(0, forKey: "miniQuizBadAnswerSimplePast")
        UserDefaults.standard.set(0, forKey: "miniQuizGoodAnswerPastParticiple")
        UserDefaults.standard.set(0, forKey: "miniQuizBadAnswerPastParticiple")
        irregularVerbCollectionView.delegate = self
        irregularVerbCollectionView.dataSource = self
        shuffledArray = irregularVerbs.shuffled()
        arrayForQuiz = verbSelectionForQuiz()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = "100 Irregular Verbs"
        quizLabel.font = fonts.largeBoldFont
        quizLabel.numberOfLines = 0
        quizLabel.textAlignment = .center
        infinitiveLabel.font = fonts.smallBoldFont
        simplePastLabel.numberOfLines = 0
        simplePastLabel.font = fonts.smallBoldFont
        simplePastLabel.text = """
        Simple Past
        """
        pastParticipleLabel.font = fonts.smallBoldFont
        pastParticipleLabel.numberOfLines = 0
        pastParticipleLabel.text = """
        Past Participle
        """
        let statisticText = """
        Quizzes
        Statistics
        """
        seeStatistics.layer.cornerRadius = quizButton.frame.height/2
        seeStatistics.titleLabel?.textAlignment = .center
        seeStatistics.titleLabel?.font = fonts.smallBoldFont
        seeStatistics.titleLabel?.numberOfLines = 0
        seeStatistics.backgroundColor = colorReference.specialGreen
        seeStatistics.titleLabel?.textColor = .white
        seeStatistics.setTitle(statisticText, for: .normal)
        messageTitleLabel.font = fonts.normalBoldFont
        messageTitleLabel.textColor = colorReference.specialGray
        messageTitleLabel.text = """
        Great Work!
        You have studied
        100 Irregular Verbs
        """
        let miniQuizButtonText = """
        See
        Mini Quiz
        Statistics
        """
        miniQuizStatisticsButton.setTitle(miniQuizButtonText, for: .normal)
        miniQuizStatisticsButton.titleLabel?.numberOfLines = 0
        miniQuizStatisticsButton.titleLabel?.textAlignment = .center
        miniQuizStatisticsButton.titleLabel?.font = fonts.smallBoldFont
        let sartOverButtonText = """
        Start Over!
        I need more
        peractice.
        """
        startOverButton.setTitle(sartOverButtonText, for: .normal)
        startOverButton.titleLabel?.numberOfLines = 0
        startOverButton.titleLabel?.textAlignment = .center
        startOverButton.titleLabel?.font = fonts.smallBoldFont
        let backToMenuButtonText = """
        Go Back
        To Menu
        """
        backToMenuButton.setTitle(backToMenuButtonText, for: .normal)
        backToMenuButton.titleLabel?.numberOfLines = 0
        backToMenuButton.titleLabel?.textAlignment = .center
        backToMenuButton.titleLabel?.font = fonts.smallBoldFont

    }
    override func viewDidAppear(_ animated: Bool) {
        quizButton.layer.cornerRadius = quizButton.frame.height/2
        seeStatistics.layer.cornerRadius = seeStatistics.frame.height/2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellsAcross: CGFloat = 3
        let cellVert: CGFloat = 5
        let dim = collectionView.frame.width / cellsAcross
        let vert = collectionView.frame.height/cellVert
        return CGSize(width: dim, height: vert)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! VerbCollectionViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.verbeTextField.text = arrayForQuiz[indexPath.item]
        cell.isUserInteractionEnabled = false
        switch indexPath.row {
        case 0, 3, 6, 9, 12:
            cell.verbeTextField.backgroundColor = colorReference.specialGray
            cell.verbeTextField.textColor = .white
            cell.verbeTextField.font = fonts.smallItaliqueBoldFont
            cell.verbeTextField2.backgroundColor = colorReference.specialGray
            cell.verbeTextField2.textColor = .white
        case 1, 4, 7, 10, 13:
            if let index = simplePast.firstIndex(of: arrayForQuiz[indexPath.item]){
                cell.verbeTextField.backgroundColor = .white
                cell.verbeTextField.textColor = .black
                cell.verbeTextField.font = fonts.smallFont
                cell.verbeTextField2.backgroundColor = .white
                cell.verbeTextField2.textColor = .black
                cell.verbeTextField2.font = fonts.smallFont
                cell.verbeTextField.text = arrayForQuiz[indexPath.item]
                cell.verbeTextField2.text = exceptionSimplePast[index]
            }
        case 2, 5, 8, 11, 14:
            if let index = pastParticiple.firstIndex(of: arrayForQuiz[indexPath.item]){
                cell.verbeTextField.backgroundColor = .white
                cell.verbeTextField.textColor = .black
                cell.verbeTextField.font = fonts.smallFont
                cell.verbeTextField2.backgroundColor = .white
                cell.verbeTextField2.textColor = .black
                cell.verbeTextField2.font = fonts.smallFont
                cell.verbeTextField.text = arrayForQuiz[indexPath.item]
                cell.verbeTextField2.text = exceptionPastParticiple[index]
            }
        default:
            break
        }
        return cell
    }
    @objc func keyBoardWillChange(notification: Notification) {
        guard let keyBoardRec = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        if keiBoardHeight == 0 {
            keiBoardHeight = keyBoardRec.height
            initialPosition = irregularVerbCollectionView.frame.minY
        }
        let low = irregularVerbCollectionView.frame.maxY
        let corr = view.frame.height - low
        let adjustement = keiBoardHeight - corr
        if notification.name == UIResponder.keyboardWillShowNotification && irregularVerbCollectionView.frame.minY ==  initialPosition{
            irregularVerbCollectionView.transform = CGAffineTransform(translationX: 0, y: -adjustement)
            seeStatistics.transform = CGAffineTransform(translationX: 0, y: -adjustement)
            quizLabel.transform = CGAffineTransform(translationX: 0, y: -adjustement)
            simplePastLabel.transform = CGAffineTransform(translationX: 0, y: -adjustement)
            pastParticipleLabel.transform = CGAffineTransform(translationX: 0, y: -adjustement)
            infinitiveLabel.transform = CGAffineTransform(translationX: 0, y: -adjustement)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellIndexPath = indexPath
        print("cellIndexPath")
        print(cellIndexPath)
        let cell = irregularVerbCollectionView.cellForItem(at: cellIndexPath) as! VerbCollectionViewCell
        cell.verbeTextField.isUserInteractionEnabled = true
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselect")
        let cell = irregularVerbCollectionView.cellForItem(at: indexPath) as! VerbCollectionViewCell
        cell.verbeTextField.isUserInteractionEnabled = false
    }
    @objc func textFieldShouldReturn(_ reponse: UITextField) -> Bool {
        var count = 0
        var cell = irregularVerbCollectionView.cellForItem(at: cellIndexPath) as! VerbCollectionViewCell
        switch cellIndexPath.item {
            case 1, 4, 7, 10, 13:
            if let index = simplePast.firstIndex(of: arrayForQuiz[cellIndexPath.item]){
                if cell.verbeTextField.text ==  arrayForQuiz[cellIndexPath.item] || (cell.verbeTextField.text == exceptionSimplePast[index] && exceptionSimplePast[index] != ""){
                    cell.verbeTextField.backgroundColor = colorReference.specialGreen
                    cell.verbeTextField2.backgroundColor = colorReference.specialGreen
                    cell.verbeTextField.text = arrayForQuiz[cellIndexPath.item]
                    cell.verbeTextField2.text = exceptionSimplePast[index]
                    cell.verbeTextField.font = fonts.smallBoldFont
                    cell.verbeTextField2.font = fonts.smallBoldFont
                    miniQuizGoodAnswerSimplePast = miniQuizGoodAnswerSimplePast + 1
                    UserDefaults.standard.set(miniQuizGoodAnswerSimplePast, forKey: "miniQuizGoodAnswerSimplePast")
                    soundPlayer?.playSound(soundName: "chime_clickbell_octave_up", type: "mp3")
                }else{
                    cell.verbeTextField.backgroundColor = colorReference.specialRed
                    cell.verbeTextField2.backgroundColor = colorReference.specialRed
                    cell.verbeTextField.text = arrayForQuiz[cellIndexPath.item]
                    cell.verbeTextField2.text = exceptionSimplePast[index]
                    cell.verbeTextField.font = fonts.smallItaliqueBoldFont
                    cell.verbeTextField2.font = fonts.smallItaliqueBoldFont
                    miniQuizBadAnswerSimplePast = miniQuizBadAnswerSimplePast + 1
                     UserDefaults.standard.set(miniQuizBadAnswerSimplePast, forKey: "miniQuizBadAnswerSimplePast")
                    soundPlayer?.playSound(soundName: "etc_error_drum", type: "mp3")
                }
            }
            case 2, 5, 8, 11, 14:
            if let index = pastParticiple.firstIndex(of: arrayForQuiz[cellIndexPath.item]){
                if cell.verbeTextField.text ==  arrayForQuiz[cellIndexPath.item] || (cell.verbeTextField.text == exceptionPastParticiple[index] && exceptionPastParticiple[index] != ""){
                    cell.verbeTextField.backgroundColor = colorReference.specialGreen
                    cell.verbeTextField2.backgroundColor = colorReference.specialGreen
                    cell.verbeTextField.text = arrayForQuiz[cellIndexPath.item]
                    cell.verbeTextField2.text = exceptionPastParticiple[index]
                    cell.verbeTextField.font = fonts.smallBoldFont
                    cell.verbeTextField2.font = fonts.smallBoldFont
                    miniQuizGoodAnswerPastParticiple = miniQuizGoodAnswerPastParticiple + 1
                    UserDefaults.standard.set(miniQuizGoodAnswerPastParticiple, forKey: "miniQuizGoodAnswerPastParticiple")
                    soundPlayer?.playSound(soundName: "chime_clickbell_octave_up", type: "mp3")
                }else{
                    cell.verbeTextField.backgroundColor = colorReference.specialRed
                    cell.verbeTextField2.backgroundColor = colorReference.specialRed
                    cell.verbeTextField.text = arrayForQuiz[cellIndexPath.item]
                    cell.verbeTextField2.text = exceptionSimplePast[index]
                    cell.verbeTextField.font = fonts.smallItaliqueBoldFont
                    cell.verbeTextField2.font = fonts.smallItaliqueBoldFont
                    soundPlayer?.playSound(soundName: "etc_error_drum", type: "mp3")
                    miniQuizBadAnswerPastParticiple = miniQuizBadAnswerPastParticiple + 1
                    UserDefaults.standard.set(miniQuizBadAnswerPastParticiple, forKey: "miniQuizBadAnswerPastParticiple")
                }
            }
            default:
            break
        }
        cell.verbeTextField.textColor = .white
        cell.verbeTextField2.textColor = .white
        cell.verbeTextField.isUserInteractionEnabled = false
        cell.isUserInteractionEnabled = false
        cell.verbeTextField.resignFirstResponder()
        while cell.verbeTextField.text != "" && count < 14{
            count = count + 1
            cell = irregularVerbCollectionView.cellForItem(at: [0 , count]) as! VerbCollectionViewCell
            cell.verbeTextField.isUserInteractionEnabled = true
            cell.verbeTextField.becomeFirstResponder()
            cellIndexPath = [0, count]
        }
        if count == 14 &&  cell.verbeTextField.text != ""{
            soundPlayer?.playSound(soundName: "music_harp_gliss_up", type: "wav")
            irregularVerbCollectionView.transform = .identity
            seeStatistics.transform = .identity
            quizLabel.transform = .identity
            simplePastLabel.transform = .identity
            pastParticipleLabel.transform = .identity
            infinitiveLabel.transform = .identity
            titleButtonNext = """
            Next
            Quiz
            """
            quizButton.setTitle(titleButtonNext, for: .normal)
            cell.verbeTextField.resignFirstResponder()
            if quizNumber == 20 {
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                effect = blurEffectView.effect
                view.addSubview(blurEffectView)
                FinishedQuizMessage.showMessageView(view: view, messageView: finishedQuizMessage, visualEffect: blurEffectView, effect: effect)
            }
        }

        return true
    }
     override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        irregularVerbCollectionView.reloadData()
        quizButton.layer.cornerRadius = quizButton.frame.height/2
        seeStatistics.layer.cornerRadius = seeStatistics.frame.height/2
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    @IBAction func unwindToMiniQuiz(_ unwindSegue: UIStoryboardSegue) {
        print(cellIndexPath)
        var count = Int()
        for n in 0...14 {
            let cell = irregularVerbCollectionView.cellForItem(at: [0, n]) as! VerbCollectionViewCell
            if cell.verbeTextField.text != "" {
                count = count + 1
            }
        }
        if cellIndexPath.item < 14 && count < 14{
            let cell = irregularVerbCollectionView.cellForItem(at: cellIndexPath) as! VerbCollectionViewCell
            cell.isUserInteractionEnabled = true
            cell.verbeTextField.isUserInteractionEnabled = true
            irregularVerbCollectionView.selectItem(at: cellIndexPath, animated: true, scrollPosition: .left)
            DispatchQueue.main.async {
                cell.verbeTextField.becomeFirstResponder()
            }
        }
        

    }
    func verbSelectionForQuiz() -> [String]{
        var chosenArray = [[String]]()
        if verbCountForQuiz < 100 {
            for index in verbCountForQuiz...verbCountForQuiz + 4{
                chosenArray.append(shuffledArray[index])
                if let indexPosition = irregularVerbs.firstIndex(of: shuffledArray[index]){
                    exceptionPastParticiple.append(exceptionsArray[indexPosition][4])
                    exceptionSimplePast.append(exceptionsArray[indexPosition][2])
                    simplePast.append(exceptionsArray[indexPosition][1])
                    pastParticiple.append(exceptionsArray[indexPosition][3])
                }
            }
        }else{
            
        }
        let totalNumbeOfQuiz = shuffledArray.count/5
        quizLabel.text = """
        Mini Quiz
        number: \(quizNumber) of \(totalNumbeOfQuiz)
        """
        arrayForQuiz = chosenArray.flatMap { $0 }
        verbCountForQuiz = verbCountForQuiz + 5
        quizNumber =  quizNumber + 1
        return arrayForQuiz
    }

    @IBAction func readyButtonPushed(_ sender: UIButton) {
        if quizButton.titleLabel?.text == titleButtonNext{
            formatForQuiz()
        }else{
            for n in 0...14 {
                let cell = irregularVerbCollectionView.cellForItem(at: [0 , n]) as! VerbCollectionViewCell
                switch n {
                case 1, 4, 7, 10, 13, 2, 5, 8, 11, 14:
                    cell.isUserInteractionEnabled = false
                    cell.verbeTextField.isUserInteractionEnabled = false
                    cell.verbeTextField.text = ""
                    cell.verbeTextField2.text = ""
                default:
                    break
                }
            }
            let cell = irregularVerbCollectionView.cellForItem(at: [0 , 1]) as! VerbCollectionViewCell
            cell.isUserInteractionEnabled = true
            cell.verbeTextField.isUserInteractionEnabled = true
            cell.verbeTextField.becomeFirstResponder()
            cellIndexPath = [0,1]
        }

    }

    @IBAction func miniQuizStatitisticsButtonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "showStatistics", sender: self)
    }
    @IBAction func startOverButtonPushed(_ sender: Any) {
        quizNumber = 0
        arrayForQuiz = verbSelectionForQuiz()
        formatForQuiz()
        FinishedQuizMessage.dismissMessageview(view: view, messageView: finishedQuizMessage, visualEffect: blurEffectView, effect: effect)
        
    }
    @IBAction func goBackTomenuButtonPushed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func formatForQuiz() {
        for n in 0...14 {
            let cell = irregularVerbCollectionView.cellForItem(at: [0 , n]) as! VerbCollectionViewCell
            cell.verbeTextField.textColor = .black
            cell.verbeTextField.backgroundColor = .white
            cell.verbeTextField2.backgroundColor = .white
            cell.isUserInteractionEnabled = false
        }
        arrayForQuiz = verbSelectionForQuiz()
        irregularVerbCollectionView.reloadData()
        quizButton.setTitle(buttonString, for: .normal)
    }
    

}
