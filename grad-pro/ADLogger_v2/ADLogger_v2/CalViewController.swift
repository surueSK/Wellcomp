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
    @IBOutlet var tableView : UITableView!
    let array:[String] = ["A"]
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        _ = UINib(nibName: "TableViewCell", bundle: nil)
      tableView.register (UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"calCell")
    }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // 一つのsectionの中に入れるCellの数を決める。
                return 10
                //return array.count // 上に定義した配列arrayの要素数
            }
            
            
            func numberOfSections(in tableView: UITableView) -> Int { // sectionの数を決める
                return 1
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                // Cellの高さを決める
                
                return 50
            }
            
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                // Cellの内容を決める（超重要）
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "calCell", for: indexPath)as? TableViewCell
                
                //tableView.dequeueReusableCell(withIdentifier: "再利用セル", for: 何個セル出すの) as! カスタムセルクラス
                //表示するセルの内容.セルに表示するデータの制御 ( 選択数はこれを使う : 何個セル出すの )
                //ここで先ほど指定した『beginnerCell』を呼んでる。
         
                //cell?.textLabel?.text = array[indexPath.row] // indexPath.rowはセルの番号
                
                return cell!
                
            }
            
            
           
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


