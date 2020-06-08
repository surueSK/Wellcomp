//
//  ListViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/06/06.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table基本設定
    
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
        var textField = UITextField()
        
        let alert = UIAlertController(title: "タスクの追加", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "追加", style: .default) { (action) in
            print(textField.text!)
            
            self.taskItem.append(textField.text!)
            textField.text = ""
            UserDefaults.standard.set( self.taskItem ,forKey: "mycell" )
            print("array: \(self.taskItem)")
            super.viewDidLoad()
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
    
    // MARK: - 画面表示
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "mycell") != nil{
            taskItem = UserDefaults.standard.object(forKey: "mycell") as! [String]
        }
        
        //tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "timercell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
