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
    // MARK: - 選択されたテーブルカラムの機能
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // チェックマークを入れる
        //let cell = tableView.cellForRow(at:indexPath)
        //cell?.accessoryType = .checkmark
            // MARK: - 選択されていないテーブルカラムの機能
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            // チェックマークを外す
            //let cell = tableView.cellForRow(at:indexPath)
            //cell?.accessoryType = .none
           
        }
    }
    // MARK: - 画面表示
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
