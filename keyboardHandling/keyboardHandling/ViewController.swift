//
//  ViewController.swift
//  keyboardHandling
//
//  Created by albert coelho oliveira on 10/17/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollViewUser: UIScrollView!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameText.delegate = self
        passwordText.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setUpTap()
    }
    
    func setUpTap(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    
    @objc func tap(gesture: UITapGestureRecognizer) {
        userNameText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    @objc   func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc  func keyboardWillChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if userNameText.isFirstResponder {
                self.view.frame.origin.y  -= keyboardSize.height
            }
            if passwordText.isFirstResponder {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
}
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
}
