//
//  SettingTableViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/08/08.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    let userDefaults = UserDefaults.standard
    // MARK: - タイマー文字透明化
    @IBOutlet weak var TimerColor: UISwitch!
    @IBAction func TCChanged(_ sender: UISwitch) {
        
        if sender.isOn{
            userDefaults.set(true, forKey: "TCValue")
        }else{
            userDefaults.set(false, forKey: "TCValue")
        }
        //ViewController().timerHour.textColor = sender.isOn ? UIColor.blue : UIColor.blue
    }
    
    // MARK: - ADLogger
    @IBOutlet weak var ADLogger: UISwitch!
    @IBAction func ADChanged(_ sender: UISwitch) {
        
        if sender.isOn{
            userDefaults.set(true, forKey: "ADValue")
        }else{
            userDefaults.set(false, forKey: "ADValue")
        }
        //ViewController().timerHour.textColor = sender.isOn ? UIColor.blue : UIColor.blue
    }
    
    func firstbool(){
        let TCBool = UserDefaults.standard.object(forKey: "TCValue")
        let ADBool = UserDefaults.standard.object(forKey: "ADValue")
        
        if TCBool == nil {
            userDefaults.set(true, forKey: "TCValue")
        }else{
            let switchBool = userDefaults.bool(forKey: "TCValue")
            TimerColor.setOn(switchBool, animated: false)
        }
        
        if ADBool == nil {
            userDefaults.set(false, forKey: "ADValue")
        }else{
            let switchBool2 = userDefaults.bool(forKey: "ADValue")
            ADLogger.setOn(switchBool2, animated: false)
        }
    }
    // MARK: - 変動バッファ
    @IBAction func mButton(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController(title: "変動バッファモード変更", message: "選択してください", preferredStyle:  UIAlertController.Style.alert)
        // Defaultボタン
        let defaultAction_1: UIAlertAction = UIAlertAction(title: "急ぎ", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in do {
                self.userDefaults.set(0, forKey: "fBuffer")
                print(UserDefaults.standard.integer(forKey: "fBuffer"))
            }
        })
        let defaultAction_2: UIAlertAction = UIAlertAction(title: "やや急ぎ", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in do {
                self.userDefaults.set(1, forKey: "fBuffer")
                print(UserDefaults.standard.integer(forKey: "fBuffer"))
            }
        })
        let defaultAction_3: UIAlertAction = UIAlertAction(title: "ややゆっくり", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in do {
                self.userDefaults.set(2, forKey: "fBuffer")
                print(UserDefaults.standard.integer(forKey: "fBuffer"))
            }
        })
        
        let defaultAction_4: UIAlertAction = UIAlertAction(title: "ゆっくり", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in do {
                self.userDefaults.set(3, forKey: "fBuffer")
                print(UserDefaults.standard.integer(forKey: "fBuffer"))
            }
        })
        // Cancelボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in do{
                print(UserDefaults.standard.integer(forKey: "fBuffer"))
            }
        })
        
        alert.addAction(defaultAction_1)
        alert.addAction(defaultAction_2)
        alert.addAction(defaultAction_3)
        alert.addAction(defaultAction_4)
        alert.addAction(cancelAction)

        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    func fBuffer(){
        let fBuffer = UserDefaults.standard.object(forKey: "fBuffer")
        if fBuffer == nil {
            self.userDefaults.set(3, forKey: "fBuffer")
        }else{
            let bufferf = userDefaults.bool(forKey: "fBuffer")
            ADLogger.setOn(bufferf, animated: false)
        }
    }
    
    
     // MARK: - 固定バッファ
    
    
    // MARK: - 画面
    
    override func viewDidLoad() {
        firstbool()
        fBuffer()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: // 「実験用設定」のセクション
          return 2
        case 1: // 「その他」のセクション
          return 2
        default: // ここが実行されることはないはず
          return 0
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
