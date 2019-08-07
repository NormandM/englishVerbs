//
//  ResultMiniQuizViewController.swift
//  EnglishVerbsQuiz
//
//  Created by Normand Martin on 2019-07-17.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import UIKit
import Charts

class ResultMiniQuizViewController: UIViewController {
    @IBOutlet weak var miniQuizStatisticsLabel: UILabel!
    @IBOutlet weak var simplePastLabel: UILabel!
    @IBOutlet weak var pastParticipleLabel: UILabel!
    @IBOutlet weak var pieChartSimplePast: PieChartView!
    @IBOutlet weak var pieChartPastParticiple: PieChartView!
    @IBOutlet weak var doneButton: UIButton!
    var miniQuizGoodAnswerSimplePast = UserDefaults.standard.integer(forKey: "miniQuizGoodAnswerSimplePast")
    var miniQuizBadAnswerSimplePast = UserDefaults.standard.integer(forKey: "miniQuizBadAnswerSimplePast")
    var miniQuizGoodAnswerPastParticiple = UserDefaults.standard.integer(forKey: "miniQuizGoodAnswerPastParticiple")
    var miniQuizBadAnswerPastParticiple = UserDefaults.standard.integer(forKey: "miniQuizBadAnswerPastParticiple")
    let fonts = FontsAndConstraintsOptions()
    let colorReference = ColorReference()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let resultSimplePast = Double(miniQuizGoodAnswerSimplePast) / Double(miniQuizGoodAnswerSimplePast + miniQuizBadAnswerSimplePast)
        let resultPastParticiple = Double(miniQuizGoodAnswerPastParticiple) / Double(miniQuizGoodAnswerPastParticiple + miniQuizBadAnswerPastParticiple)
        let simplePastPercent = String(round(resultSimplePast * 100)) + " %"
        let pastParticiplePercent = String(round(resultPastParticiple * 100)) + " %"
        miniQuizStatisticsLabel.font = fonts.largeBoldFont
        simplePastLabel.text = "Simple Past \(simplePastPercent)"
        simplePastLabel.font = fonts.normalBoldFont
        pastParticipleLabel.font = fonts.normalBoldFont
        pastParticipleLabel.text = "Past Participle \(pastParticiplePercent)"
        doneButton.layer.cornerRadius = doneButton.frame.height/2
        doneButton.titleLabel?.textAlignment = .center
        doneButton.titleLabel?.font = fonts.smallBoldFont
        doneButton.titleLabel?.numberOfLines = 0
        doneButton.backgroundColor = colorReference.specialGreen
        doneButton.titleLabel?.textColor = .white
    }
    override func viewDidAppear(_ animated: Bool) {
        setUpChart()
        doneButton.layer.cornerRadius = doneButton.frame.height/2
    }
    func setUpChart() {
        let pieChartSetupSimplePast = PieChartSetUp(entrieBon: Double(miniQuizGoodAnswerSimplePast), entrieMal: Double(miniQuizBadAnswerSimplePast), entrieAide: 0, pieChartView: pieChartSimplePast)
        let pieChartSetUpPastParticiple = PieChartSetUp(entrieBon: Double(miniQuizGoodAnswerPastParticiple), entrieMal: Double(miniQuizBadAnswerPastParticiple), entrieAide: 0, pieChartView: pieChartPastParticiple)
        pieChartSimplePast.data = pieChartSetupSimplePast.piechartData
        pieChartPastParticiple.data = pieChartSetUpPastParticiple.piechartData
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        doneButton.layer.cornerRadius = doneButton.frame.height/2
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func donePushed(_ sender: UIButton) {
        performSegue(withIdentifier: "backToMiniquiz", sender: self)
    }
    
}
