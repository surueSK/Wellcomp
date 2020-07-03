//
//  TimeViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/07/03.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
import Parse

class TimeViewController: UIViewController {
    var status: Bool = false
    @IBOutlet weak var startLabel: UILabel!
    
    @IBAction func labelTap(_ sender: Any) {
        if (status) {
        startLabel.text = "実験開始"
        status = true
        } else {
        startLabel.text = "実験終了"
        status = false
        }
    }

    /*後々使うかもと思ったのでコードだけ残しておく
    var countNum = 0
    var timerRunning = false
    var timer = Timer()
    
    @IBOutlet weak var timeDisplay: UILabel!
    @objc func updateDisplay(){
        countNum += 1
        let ms = countNum % 100
        let s = (countNum - ms) / 100 % 60
        let m = (countNum - s - ms) / 6000 % 3600
        timeDisplay.text = String(format: "%02d:%02d.%02d", m,s,ms)
 */
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
