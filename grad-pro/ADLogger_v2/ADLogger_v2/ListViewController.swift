//
//  ListViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/06/06.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
import Parse

class ListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table基本設定
     @IBOutlet var tableView : UITableView!
    // テーブルに表示するデータの準備
    var taskItem : [String] = []
    
    // テーブルの行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskItem.count
    }
    // セルの中身を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        // セルに値を設定する
        cell.textLabel!.text = taskItem[indexPath.row]
        return cell
       
    }
    
    // MARK: - Table機能追加
    
    @IBOutlet var newListButton:UIButton!
    @IBAction func newListButtonPressed(_ sender: Any) {

     // MARK: - アラート
        
        //ここからアラート
        let alert2: UIAlertController = UIAlertController(title: "保存完了", message: "ご協力有難うございました", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction2: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
               (action: UIAlertAction!)  in
               //アラートが消えるのと画面遷移が重ならないように0.5秒後に画面遷移するようにしてる
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // 0.5秒後に実行したい処理(計測に戻る)
                 //self.navigationController?.popViewController(animated: true)
                }
           })
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "タスクの追加", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "追加", style: .default) { (action) in
            print(textField.text!)
            
            self.taskItem.append(textField.text!)
            textField.text = ""
            UserDefaults.standard.set( self.taskItem ,forKey: "mycell" )
            print("array: \(self.taskItem)")
            self.tableView.reloadData()
            alert2.addAction(defaultAction2)
            self.present(alert2, animated: true, completion: nil)
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "新しいアイテム"
            textField = alertTextField

        }
           // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.cancel, handler:{
               (action: UIAlertAction!) -> Void in
               
           })

        alert.addAction(cancelAction)
        alert.addAction(action)
       present(alert, animated: true, completion: nil)
   
    }
    
    // MARK: - テーブルミニ機能たち
    
    // スワイプでのアイテム削除機能　てかこの機能はあとで消すかも
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // アイテム削除処理
        taskItem.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
       
     }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // チェックマークを入れる
        cell?.accessoryType = .checkmark
        
        //ここからアラート
        let alert: UIAlertController = UIAlertController(title: "保存完了", message: "ご協力有難うございました", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction1: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
               (action: UIAlertAction!)  in
               //アラートが消えるのと画面遷移が重ならないように0.5秒後に画面遷移するようにしてる
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // 0.5秒後に実行したい処理(計測に戻る)
                 //self.navigationController?.popViewController(animated: true)
                }
           })
        
           alert.addAction(defaultAction1)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // チェックマークを外す
        cell?.accessoryType = .none
       
    }

    

    // MARK: - 画面表示
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "mycell") != nil{
            taskItem = UserDefaults.standard.object(forKey: "mycell") as! [String]
        }
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
