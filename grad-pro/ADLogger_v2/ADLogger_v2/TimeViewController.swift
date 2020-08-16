//
//  TimeViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/07/03.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
import Parse

class TimeViewController: UIViewController {
    
    
    @IBOutlet weak var ADLogger: UIButton!
    @IBAction func toADLogger(_ sender: UIButton) {
        let ADBool = UserDefaults.standard.object(forKey: "ADValue")
        if ADBool == nil {
            print("no")
        }else if (ADBool as! Int != 0) {
            print("yes")
            self.performSegue(withIdentifier: "toLog", sender: nil)
        }else{
            print("no")
        }
        
        
    }
    
    
    /*
    var status: Bool = false

    @IBOutlet var startButton: UIButton!
    @IBAction func startStop(){
        if (status) {
            self.performSegue(withIdentifier: "toListViewController", sender: nil)
        } else {
            startButton.setTitle("STOP", for: .normal)
        }
    }
    */

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
