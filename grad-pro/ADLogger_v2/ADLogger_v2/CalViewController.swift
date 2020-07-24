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
    var array:[String] = []
    var dicTTime:[String:Int] = ["ダミー":1]
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
      tableView.register (UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"calCell")
        read()
    }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // 一つのsectionの中に入れるCellの数を決める。
                return array.count // 上に定義した配列arrayの要素数
            }
            
            
            func numberOfSections(in tableView: UITableView) -> Int { // sectionの数を決める
                return 1
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                // Cellの内容を決める（超重要）
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "calCell", for: indexPath)as? TableViewCell
         
                cell?.textLabel?.text = array[indexPath.row] // indexPath.rowはセルの番号 ここが肝？
                
                return cell!
                
            }
            // MARK: - 読み出し(READ)
    func read() {
        let query = PFQuery(className:"tasktime")
             //キャッシュに溜める
        query.cachePolicy = PFCachePolicy.networkElseCache
        query.order(byDescending: "createdAt")
        query.whereKey("username", contains: UserDefaults.standard.object(forKey:"userName") as? String)
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                if let returnedobjects = objects{
                    for objects in returnedobjects{
                        //print(objects as Any)
                        //print(objects["tasktime"] as! Int)
                        self.dicTTime.updateValue(objects["tasktime"] as! Int, forKey: objects["taskname"] as! String)
                        print(self.dicTTime)
                        
                        self.array.append(objects["taskname"] as! String)
                        self.tableView.reloadData()
                    }
                }
       } else {
           //エラーあり
                print(error as Any)
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
        
    }
}
