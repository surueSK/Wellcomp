//
//  CalViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/06/08.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
import Parse

class CalViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table基本設定
    
    @IBOutlet weak var totalHour: UILabel!
    @IBOutlet weak var totalMin: UILabel!
    @IBOutlet weak var totalSec: UILabel!
    
    @IBOutlet weak var bHour: UILabel!
    @IBOutlet weak var bMin: UILabel!
    @IBOutlet weak var bSec: UILabel!
    
    @IBOutlet weak var b2Hour: UILabel!
    @IBOutlet weak var b2Min: UILabel!
    @IBOutlet weak var b2Sec: UILabel!
    
    @IBOutlet var tableView : UITableView!
    var dic:[String:[Int]] = [:]
    var aveTime: [Int] = []
    var devTime: [Int] = []
    var cTime: [Int] = []
    var bTime: [Int] = []
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register (UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"calCell")
        // trueで複数選択、falseで単一選択
        tableView.allowsMultipleSelection = true
        read()
    }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // 一つのsectionの中に入れるCellの数を決める。
                return dic.count // 上に定義した配列arrayの要素数
            }
            
            
            func numberOfSections(in tableView: UITableView) -> Int { // sectionの数を決める
                return 1
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                // Cellの内容を決める（超重要）
                let cell = tableView.dequeueReusableCell(withIdentifier: "calCell", for: indexPath)as? TableViewCell
                let hour = aveTime[indexPath.row]/3600
                let min = aveTime[indexPath.row]/60 % 60
                let sec = aveTime[indexPath.row] % 60
                //String(format: "%02d", hour)
                cell?.textLabel?.text = "\([String](dic.keys)[indexPath.row]) ： \(String(format: "%02d", hour)):\(String(format: "%02d", min)):\(String(format: "%02d", sec))"
                return cell!
                
            }
    // MARK: - 読み出し(READ)
    func read() {
        let query = PFQuery(className:"tasktime")
        query.cachePolicy = PFCachePolicy.networkElseCache
        query.order(byDescending: "createdAt")
        query.whereKey("username", contains: UserDefaults.standard.object(forKey:"userName") as? String)
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                if let returnedobjects = objects{
                    
                    for objects in returnedobjects{
                        
                        if (self.dic[objects["taskname"] as! String] == nil){
                            self.dic.updateValue([objects["tasktime"] as! Int], forKey: objects["taskname"] as! String)
                        }else{
                            self.dic[objects["taskname"] as! String]?.append(objects["tasktime"] as! Int)
                        }
                    
                    }
                    self.ccal()
                    self.tableView.reloadData()
                }
                
       } else {
                print(error as Any)//エラー有
            }
        }
    }
    // MARK: - 平均の計算
    func ccal(){
        let fbuffer = UserDefaults.standard.integer(forKey: "fBuffer")
        
        for task in dic {
            let sum: Int = task.value.reduce(0) { $0 + $1 }
            let ave = sum/task.value.count
            //let max = task.value.max()! as Int
            //let min = task.value.min()! as Int
            var sum2 = 0
            //devTime.append((max-min)/2) //理論面要確認！
            //aveTime.append((max + 4 * ave + min)/6)//3点見積もり法
            aveTime.append(ave)
            
            for i in 0..<task.value.count {
                let exp = (task.value[i]-ave)*(task.value[i]-ave)
                sum2 = sum2+exp
            }
            let dev = sqrt(Double(sum2/task.value.count))
            devTime.append(Int(dev)*fbuffer)
            print(fbuffer)
            //標準偏差をdevTimeに代入
            
            }
    }
    // MARK: - 合計値
    // セルが選択された時に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)

        // チェックマークを入れる
        cell?.accessoryType = .checkmark
        cTime.append(aveTime[indexPath.row] + devTime[indexPath.row])
        bTime.append(devTime[indexPath.row])
        calculate()
    }

    // セルの選択が外れた時に呼び出される
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)

        // チェックマークを外す
        cell?.accessoryType = .none
        cTime.append(-(aveTime[indexPath.row] + devTime[indexPath.row]))
        bTime.append(-devTime[indexPath.row])
        calculate()
    }
    
    func calculate(){
        let abuffer = UserDefaults.standard.integer(forKey: "aBuffer")
        let fbuffer = UserDefaults.standard.integer(forKey: "fBuffer")
        let cSum = cTime.reduce(0, +)+abuffer
        let bSum = bTime.reduce(0, +)
        totalHour.text = String(format: "%02d", cSum/3600)
        totalMin.text = String(format: "%02d", cSum/60 % 60)
        totalSec.text = String(format: "%02d", cSum % 60)
        bHour.text = String(format: "%02d", bSum/3600)
        bMin.text = String(format: "%02d", bSum/60 % 60)
        bSec.text = String(format: "%02d", bSum % 60)
        b2Hour.text = String(format: "%02d", abuffer/3600)
        b2Min.text = String(format: "%02d", abuffer/60 % 60)
        b2Sec.text = String(format: "%02d", abuffer % 60)
        
        if fbuffer == 0{
            bHour.textColor = UIColor.red
            bMin.textColor = UIColor.red
            bSec.textColor = UIColor.red
        }
        else if fbuffer == 1{
            bHour.textColor = UIColor.orange
            bMin.textColor = UIColor.orange
            bSec.textColor = UIColor.orange
        }
        else if fbuffer == 2{
            bHour.textColor = UIColor.green
            bMin.textColor = UIColor.green
            bSec.textColor = UIColor.green
        }else{
            bHour.textColor = UIColor.blue
            bMin.textColor = UIColor.blue
            bSec.textColor = UIColor.blue
        }
    }
    // MARK: - チェック機能
    @IBAction func BCheck(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController(title: "精度チェッカー", message: "現在選択されたタスクをストップウォッチで計測する事でアプリの精度を策定します", preferredStyle:  UIAlertController.Style.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            if self.cTime.reduce(0, +) == 0 {
                self.error()
            }else{
                //測定画面へGO
            }
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })

        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    // MARK: - チェックのエラーアラート
    func error(){
        let alert: UIAlertController = UIAlertController(title: "WARNING", message: "タスクが選択されていません", preferredStyle:  UIAlertController.Style.alert)

    
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        
        alert.addAction(defaultAction)

        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func toCalendar(_ sender: Any) {
        self.performSegue(withIdentifier: "toCalendar", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCalendar" {
            let nextVC = segue.destination as! CalendarViewController
            let abuffer = UserDefaults.standard.integer(forKey: "aBuffer")
            let cSum = cTime.reduce(0, +)+abuffer
            nextVC.times = cSum
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
