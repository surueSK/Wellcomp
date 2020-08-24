//
//  ExpViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/08/24.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
import Parse

class ExpViewController: UIViewController {
    
    @IBOutlet weak var etname: UITextField!
    @IBOutlet weak var ehour: UITextField!
    @IBOutlet weak var emin: UITextField!
    @IBOutlet weak var esec: UITextField!
    @IBOutlet weak var ebutton: UIButton!
    
    @IBAction func eOK(_ sender: Any) {
        
        //alertで1段階おく！
        
        let parseObject = PFObject(className:"survey")
        parseObject["username"] = UserDefaults.standard.object(forKey:"userName")
        parseObject["taskname"] = etname.text!
        parseObject["tasktime"] = 1
        
        
        
        
        
    }
    
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
