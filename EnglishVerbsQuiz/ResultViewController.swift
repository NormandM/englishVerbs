//
//  ResultViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-09.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import Charts


class ResultViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultat: UILabel!
    @IBOutlet weak var message: UILabel!

    @IBOutlet weak var scoreChart: PieChartView!
    var totalProgress: Double = 0
    var goodResponse: Double = 0
    var badResponse = Double()
    var aideCount = Double()
    var tryAgainButton = UIButton()
    let fonts = FontsAndConstraintsOptions()
    override func viewDidLoad() {
        super.viewDidLoad()
        goodResponse = Double(UserDefaults.standard.integer(forKey: "thisQuizGoodAnswer"))
        aideCount = Double(UserDefaults.standard.integer(forKey: "thisQuizHintAnswer"))
        badResponse = Double(UserDefaults.standard.integer(forKey: "thisQuizBadAnswer"))
        resultat.text = "\(Int(goodResponse + aideCount))/\(Int(totalProgress))"
        let result = Double(goodResponse + aideCount)/Double(totalProgress)
        let resultPercent = String(round(result*100)) + " %"
        if result == 1.0{
            message.text = "Perfect! "
        }else if result < 1 && Double(result) >= 0.75 {
            message.text = "\(resultPercent) Very Good!"
        }else if Double(result) >= 0.6 && Double(result) < 0.75 {
            message.text = "\(resultPercent) Not Bad!"
        }else if result >= 0 && Double(result) < 0.6 {
            message.text = "\(resultPercent) Try again!"
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let yPosition = view.frame.height * 0.9
        let buttonWidth = view.frame.height * 0.08
        let xPosition = view.frame.width/2 - buttonWidth/2
        let buttonHeight = buttonWidth
        tryAgainButton = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: buttonHeight))
        tryAgainButton.layer.cornerRadius = tryAgainButton.frame.height/2
        tryAgainButton.backgroundColor = UIColor(red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0)
        tryAgainButton.titleLabel?.textColor = UIColor.white
        let buttonName = """
        Try
        Again
        """
        tryAgainButton.titleLabel?.textAlignment = .center
        tryAgainButton.titleLabel?.numberOfLines = 0
        tryAgainButton.titleLabel?.lineBreakMode = .byWordWrapping
        tryAgainButton.setTitle(buttonName, for: .normal)
        tryAgainButton.titleLabel?.font = fonts.smallBoldFont
        self.view.addSubview(tryAgainButton)
        tryAgainButton.addTarget(self, action: #selector(tryAgainButtonPushed), for: .touchUpInside)
    }
    override func viewDidAppear(_ animated: Bool) {
        let fonts = FontsAndConstraintsOptions()
        titleLabel.font = fonts.largeBoldFont
        resultat.font = fonts.normalBoldFont
        message.font = fonts.normalItaliqueBoldFont
        setupChart()
    }
    override func viewWillDisappear(_ animated: Bool) {
        tryAgainButton.removeFromSuperview()
    }
    func setupChart() {
        let entrieBon = goodResponse
        let entrieMal = badResponse
        let entrieAide = aideCount
        let pieChartSetUp = PieChartSetUp(entrieBon: entrieBon, entrieMal: entrieMal, entrieAide: entrieAide, pieChartView: scoreChart)
        scoreChart.data = pieChartSetUp.piechartData
    }
   
    // MARK: - Navigation
    

    @objc func tryAgainButtonPushed() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
