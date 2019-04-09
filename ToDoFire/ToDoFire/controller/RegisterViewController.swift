//
//  RegisterViewController.swift
//  ToDoFire
//
//  Created by Сергей Гриневич on 07/04/2019.
//  Copyright © 2019 Green. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailText.text = ""
        passwordText.text = ""

    }
    

    
    func warningLabelText(warningLAbel text: String )
    {
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }) { [weak self] (complete) in
            self?.warnLabel.alpha = 0
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        guard let email = emailText.text, let password = passwordText.text, email != "", password != "" else {
            warningLabelText(warningLAbel: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil
            {
                self?.warningLabelText(warningLAbel: "Error ocurred")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: "taskssegue", sender: nil)
                return
            }
            
            self?.warningLabelText(warningLAbel: "No user")
            
        }
        
    }
    @IBAction func registerTapped(_ sender: UIButton) {
        
        guard let email = emailText.text, let password = passwordText.text, email != "", password != "" else {
            warningLabelText(warningLAbel: "Info is incorrect")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil
            {
                if user != nil
                {
                    
                } else
                {
                    print("user is not created")
                }
            }
            else
            {
                print(error!.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //скрыть клавиатуру
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)

        warnLabel.alpha = 0
        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil
            {
                self?.performSegue(withIdentifier: "taskssegue", sender: nil)
            }
        }
    }
    
    //клава
    @objc func keyboardDidShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height
//            }
            (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + keyboardSize.height )
            (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height , right: 0)
        }
        
    }
    //клава
    @objc func keyboardDidHide(notification: Notification) {

             (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height )
            
        }
    
    
    
}
