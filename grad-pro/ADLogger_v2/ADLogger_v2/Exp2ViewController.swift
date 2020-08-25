//
//  Exp2ViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/08/25.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
import Parse

class Exp2ViewController: UIViewController {
    
    @IBOutlet weak var e2hour: UITextField!
    @IBOutlet weak var e2min: UITextField!
    @IBOutlet weak var e2sec: UITextField!
    @IBOutlet weak var e2button: UIButton!
    @IBAction func e2OK(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "確認", message: "保存しても良いですか？", preferredStyle:  UIAlertController.Style.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in do {
                let hour = Int(self.e2hour.text!)
                let min = Int(self.e2min.text!)
                let sec = Int(self.e2sec.text!)
                
                if (hour == nil) || (min == nil) || (sec == nil){
                    
                    let alert: UIAlertController = UIAlertController(title: "エラー", message: "00:00:00の形式で入力してください", preferredStyle:  UIAlertController.Style.alert)
                    let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                        (action: UIAlertAction!) -> Void in
                    })
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    let parseObject = PFObject(className:"survey2")
                    let ettime = hour!*60*60 + min!*60 + sec!
                    parseObject["username"] = UserDefaults.standard.object(forKey:"userName")
                    parseObject["totaltime"] = ettime
                    // Saves the new object.
                    parseObject.saveInBackground {
                      (success: Bool, error: Error?) in
                      if (success) {
                        print("OK")
                        print(ettime)
                        //ここじゃ無い？
                        let alert: UIAlertController = UIAlertController(title: "保存完了", message: "ご協力有難うございます！", preferredStyle:  UIAlertController.Style.alert)
                                           let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                                            (action: UIAlertAction!) -> Void in do{
                                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! UINavigationController
                                                self.present(loggedInViewController, animated: true, completion: nil)
                                            }
                                           })
                                           alert.addAction(defaultAction)
                                           self.present(alert, animated: true, completion: nil)
                      } else {
                        print("error")
                      }
                    }
                }
                
            }
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })

        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
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
