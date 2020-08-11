//
//  ViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/05/21.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
import Parse
 
class ViewController: UIViewController {
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var status: Bool = false
    @IBOutlet var startButton: UIButton!
    @IBOutlet var timerHour: UILabel!
    @IBOutlet var timerMinute: UILabel!
    @IBOutlet var timerSecond: UILabel!
    @IBAction func startStop(){
    // MARK: - 分岐
        
        if (status) {
            stop()
            startButton.setTitle("START", for: .normal)
        } else {
            start()
            startButton.setTitle("STOP", for: .normal)
        }
    }
    
    weak var timer: Timer!
    var startTime : Double = 0
    var elapsed: Double = 0

    func start(){
        timer?.invalidate()
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        status = true
    }
    func stop(){
        elapsed = Date().timeIntervalSinceReferenceDate - startTime
        timer?.invalidate()
        status = false
        
    func restart(){
        startTime = Date().timeIntervalSinceReferenceDate - elapsed
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        status = true
        }
    // MARK: - アラート
        
        let alert: UIAlertController = UIAlertController(title: "計測を終了しますか？", message: "計測を終了する場合は終了ボタンを押してタスク選択", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction1: UIAlertAction = UIAlertAction(title: "終了", style: UIAlertAction.Style.default, handler:{
               (action: UIAlertAction!)  in
               //アラートが消えるのと画面遷移が重ならないように0.5秒後に画面遷移するようにしてる
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // 0.5秒後に実行したい処理
                 self.performSegue(withIdentifier: "toListViewController", sender: nil)
                }
           })
        
        let defaultAction2: UIAlertAction = UIAlertAction(title: "計測に戻る", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            restart()
            self.startButton.setTitle("STOP", for: .normal)
        })
        
           // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.cancel, handler:{
               (action: UIAlertAction!) -> Void in
                self.timer?.invalidate()
                self.timerHour.text = "00"
                self.timerMinute.text = "00"
                self.timerSecond.text = "00"
           })

           alert.addAction(cancelAction)
           alert.addAction(defaultAction1)
           alert.addAction(defaultAction2)
        
        present(alert, animated: true, completion: nil)
    }
    
        // MARK: - 色替え
    
    func changeColor(){
        let TCBool = UserDefaults.standard.object(forKey: "TCValue")
        if (TCBool as! Int != 0) {
            print("yes")
            self.timerHour.isHidden = true
            self.timerMinute.isHidden = true
            self.timerSecond.isHidden = true
            
        }else{
            print("no")
            self.timerHour.isHidden = false
            self.timerMinute.isHidden = false
            self.timerSecond.isHidden = false
        }
    }
       // MARK: - タイマー
    
    var time: Double = 0
 
    @objc func updateCounter() {
        
        // Calculate total time since timer started in seconds
        time = Date().timeIntervalSinceReferenceDate - startTime
        let hours = Int(time)/3600
        let minutes = Int(time)/60 % 60
        let seconds = Int(time) % 60
        
        // Format time vars with leading zero
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        // Add time vars to relevant labels
        timerHour.text = strHours
        timerMinute.text = strMinutes
        timerSecond.text = strSeconds
    }
    
        // MARK: - 画面表示
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColor()
        // 画面背景色を設定してみました
        //self.view.backgroundColor = UIColor(red:0.9,green:1.0,blue:0.9,alpha:1.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.didReceiveMemoryWarning()
        super.viewWillDisappear(true)
        timer?.invalidate()
    }
    override func viewDidAppear(_ animated: Bool) {
        appDelegate?.startPushNotifications()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toListViewController" {
            let nextVC = segue.destination as! ListViewController
            nextVC.times = Int(time)
        }
    }
    
   // MARK: - ログイン関連
    /*
    @IBAction func logoutOfApp(_ sender: UIButton) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        PFUser.logOutInBackground { (error: Error?) in
            UIViewController.removeSpinner(spinner: sv)
            if (error == nil){
                self.loadLoginScreen()
            }else{
                if let descrip = error?.localizedDescription{
                    self.displayMessage(message: descrip)
                }else{
                    self.displayMessage(message: "error logging out")
                }

            }
        }
    }
*/
    func displayMessage(message:String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(viewController, animated: true, completion: nil)
    }
}
