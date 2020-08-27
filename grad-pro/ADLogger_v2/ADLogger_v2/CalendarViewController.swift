//
//  CalendarViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/08/27.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var sec: UILabel!
    var times = 0
    @IBAction func addCalendar(_ sender: Any) {
        print(times)
    }
    
    // MARK: - DatePicker関連
       
       var datePicker: UIDatePicker = UIDatePicker()
       
      override func viewDidLoad() {
           super.viewDidLoad()
           
           // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
           datePicker.timeZone = NSTimeZone.local
           datePicker.locale = Locale.current
           textField.inputView = datePicker
           
           // 決定バーの生成
           let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
           let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
           let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
           toolbar.setItems([spacelItem, doneItem], animated: true)
           
           // インプットビュー設定
           textField.inputView = datePicker
           textField.inputAccessoryView = toolbar
           
           // デフォルト日付
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           datePicker.date = formatter.date(from: "2018-5-14")!
       }
       
       // 決定ボタン押下
       @objc func done() {
           textField.endEditing(true)
           
           // 日付のフォーマット
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           textField.text = "\(formatter.string(from: Date()))"
       }
    
    
}
