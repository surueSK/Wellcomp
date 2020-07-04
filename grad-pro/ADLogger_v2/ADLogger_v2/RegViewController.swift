//
//  RegViewController.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/06/20.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit
import Parse

class RegViewController: UIViewController {
    
    @IBOutlet fileprivate var signUpUsernameField: UITextField!
    @IBOutlet fileprivate var signUpPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpUsernameField.text = ""
        signUpPasswordField.text = ""
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
        override func viewDidAppear(_ animated: Bool) {
            let currentUser = PFUser.current()
            if currentUser != nil {
                loadHomeScreen()
            }
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        func loadHomeScreen(){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! UINavigationController
            self.present(loggedInViewController, animated: true, completion: nil)
        }

        @IBAction func signUp(_ sender: UIButton) {
            let user = PFUser()
            user.username = signUpUsernameField.text
            user.password = signUpPasswordField.text
            let sv = UIViewController.displaySpinner(onView: self.view)
            
            user.signUpInBackground { (success, error) in
                UIViewController.removeSpinner(spinner: sv)
                if success{
                    self.loadHomeScreen()
                    let ud = UserDefaults.self
                    ud.standard.set(self.signUpUsernameField.text, forKey: "userName")
                }else{
                    if let descrip = error?.localizedDescription{
                        self.displayErrorMessage(message: descrip)
                    }
                }
            }
        }

        func displayErrorMessage(message:String) {
            let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertView.addAction(OKAction)
            if let presenter = alertView.popoverPresentationController {
                presenter.sourceView = self.view
                presenter.sourceRect = self.view.bounds
            }
            self.present(alertView, animated: true, completion:nil)
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
