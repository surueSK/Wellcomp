//
//  CalViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/06/08.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
import Parse

class CalViewController: UIViewController {
        // MARK: - Table基本設定
    @IBOutlet var tableView : UITableView!

    // テーブルに表示するデータの準備
    var calItem : [String] = []
    
    // テーブルの行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calItem.count
    }
    // セルの中身を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "calCell", for: indexPath)
        // セルに値を設定する
        cell.textLabel!.text = calItem[indexPath.row]
        return cell
       
    }

    // MARK: - 選択されたテーブルカラムの機能
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // チェックマークを入れる
        let cell = tableView.cellForRow(at:indexPath)
        cell?.accessoryType = .checkmark
    }
            // MARK: - 選択されていないテーブルカラムの機能
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            // チェックマークを外す
        let cell = tableView.cellForRow(at:indexPath)
        cell?.accessoryType = .none
           
        }
    // MARK: - 画面表示
    override func viewDidLoad() {
        super.viewDidLoad()
        
            if UserDefaults.standard.object(forKey: "mycell") != nil{
                calItem = UserDefaults.standard.object(forKey: "mycell") as! [String]
            }
            
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "timercell")
        }
        

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


