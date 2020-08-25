//
//  ExpViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/08/24.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
import Parse

class ExpViewController: UIViewController {
    
    @IBOutlet weak var etname: UITextField!
    @IBOutlet weak var ehour: UITextField!
    @IBOutlet weak var emin: UITextField!
    @IBOutlet weak var esec: UITextField!
    @IBOutlet weak var ebutton: UIButton!
    
    @IBAction func eOK(_ sender: Any) {
        alert1()
    }
    
    func alert1(){
        let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "保存しても良いですか？", preferredStyle:  UIAlertController.Style.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in do {
                let hour = Int(self.ehour.text!)
                let min = Int(self.emin.text!)
                let sec = Int(self.esec.text!)
                
                if self.etname == nil{
                    print("nil")//なぜかうまくいかないけど一旦放置
                    
                }else if (hour == nil) || (min == nil) || (sec == nil){
                    
                    let alert: UIAlertController = UIAlertController(title: "エラー", message: "00:00:00の形式で入力してください", preferredStyle:  UIAlertController.Style.alert)
                    let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                        (action: UIAlertAction!) -> Void in
                    })
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    let parseObject = PFObject(className:"survey")
                    let ettime = hour!*60*60 + min!*60 + sec!
                    parseObject["username"] = UserDefaults.standard.object(forKey:"userName")
                    parseObject["taskname"] = self.etname.text!
                    parseObject["tasktime"] = ettime
                    // Saves the new object.
                    parseObject.saveInBackground {
                      (success: Bool, error: Error?) in
                      if (success) {
                        print("OK")
                        print(ettime)
                        self.alert2()
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
    
    func alert2(){
        
        let alert: UIAlertController = UIAlertController(title: "タスク登録完了", message: "タスクを登録しました", preferredStyle:  UIAlertController.Style.alert)

        let defaultAction_1: UIAlertAction = UIAlertAction(title: "次のタスク登録へ", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in do{
                self.loadView()
                self.viewDidLoad()
            }
        })
        let defaultAction_2: UIAlertAction = UIAlertAction(title: "総時間登録へ", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in do{
                
            }
        })
        // ③ UIAlertControllerにActionを追加
        alert.addAction(defaultAction_1)
        alert.addAction(defaultAction_2)
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
