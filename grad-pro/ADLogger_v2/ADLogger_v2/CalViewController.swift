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
                cell?.textLabel?.text = "\([String](dic.keys)[indexPath.row]) ： \(aveTime[indexPath.row]/3600):\(aveTime[indexPath.row]/60 % 60):\(aveTime[indexPath.row] % 60)"
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
                    self.ave()
                    self.deviation()
                    self.tableView.reloadData()
                }
                
       } else {
                print(error as Any)//エラー有
            }
        }
    }
    // MARK: - 平均の計算
    func ave(){
        for task in dic {
            let sum: Int = task.value.reduce(0) { $0 + $1 }
            let ave = sum/task.value.count
            let max = task.value.max()! as Int
            let min = task.value.min()! as Int
            aveTime.append((max + 4 * ave + min)/6) //3点見積もり法
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

    func deviation(){
        for task in dic{
            let max = task.value.max()! as Int
            let min = task.value.min()! as Int
            devTime.append((max-min)/2) //理論面要確認！
        }
        
    }
    func calculate(){
        let cSum = cTime.reduce(0, +)
        let bSum = bTime.reduce(0, +)
        totalHour.text = String(cSum/3600)
        totalMin.text = String(cSum/60 % 60)
        totalSec.text = String(cSum % 60)
        bHour.text = String(bSum/3600)
        bMin.text = String(bSum/60 % 60)
        bSec.text = String(bSum % 60)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
