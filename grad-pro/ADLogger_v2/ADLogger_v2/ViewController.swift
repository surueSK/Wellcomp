//
//  ViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/05/21.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
 
class ViewController: UIViewController {
 
    @IBOutlet var timerButton: UIButton!
    @IBOutlet var timerHour: UILabel!
    @IBOutlet var timerMinute: UILabel!
    @IBOutlet var timerSecond: UILabel!
   // @IBOutlet var timerMSec: UILabel!
    
    weak var timer: Timer!
    var startTime = Date()
    var status: Bool = false
    
    @IBAction func timerCount(){
    // MARK: - 分岐
        
        if (status) {
            stop()
        } else {
            start()
        }
    }
    
    func start(){
        timerButton.setTitle("STOP", for: .normal)
        status = true
    }
    func stop(){
        timerButton.setTitle("START", for: .normal)
        status = false
        
    // MARK: - アラート
        
        let alert: UIAlertController = UIAlertController(title: "計測を終了しますか？", message: "計測を終了する場合は終了ボタンを押してタスク選択", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction1: UIAlertAction = UIAlertAction(title: "終了", style: UIAlertAction.Style.default, handler:{
               (action: UIAlertAction!) -> Void in
               print("記録画面へ移行")
           })
        
        let defaultAction2: UIAlertAction = UIAlertAction(title: "計測に戻る", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("計測に戻る")
        })
        
           // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.cancel, handler:{
               (action: UIAlertAction!) -> Void in
               print("Reset")
           })

           alert.addAction(cancelAction)
           alert.addAction(defaultAction1)
           alert.addAction(defaultAction2)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面背景色を設定してみました
        //self.view.backgroundColor = UIColor(red:0.9,green:1.0,blue:0.9,alpha:1.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
    }
    
}
