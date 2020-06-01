//
//  ViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/05/21.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
 
class ViewController: UIViewController {
    var status: Bool = false
    @IBOutlet var startButton: UIButton!
    @IBAction func startStop(){
    // MARK: - 分岐
        
        if (status) {
            stop()
        } else {
            start()
        }
    }
    
    func start(){
        startButton.setTitle("STOP", for: .normal)
        status = true
    }
    func stop(){
        startButton.setTitle("START", for: .normal)
        status = false
        
    // MARK: - アラート
        
        let alert: UIAlertController = UIAlertController(title: "計測を終了しますか？", message: "計測を終了する場合は終了ボタンを押してタスク選択", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction1: UIAlertAction = UIAlertAction(title: "終了", style: UIAlertAction.Style.default, handler:{
               (action: UIAlertAction!)  in
               //アラートが消えるのと画面遷移が重ならないように0.5秒後に画面遷移するようにしてる
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // 0.5秒後に実行したい処理
                 self.performSegue(withIdentifier: "StorageView", sender: nil)
                }
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
    
        // MARK: - タイマー
    weak var timer: Timer!
    var startTime = Date()
    @IBOutlet var timerHour: UILabel!
    @IBOutlet var timerMinute: UILabel!
    @IBOutlet var timerSecond: UILabel!
    
        // MARK: - 画面表示
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面背景色を設定してみました
        //self.view.backgroundColor = UIColor(red:0.9,green:1.0,blue:0.9,alpha:1.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //timer.invalidate()
    }
    
}
