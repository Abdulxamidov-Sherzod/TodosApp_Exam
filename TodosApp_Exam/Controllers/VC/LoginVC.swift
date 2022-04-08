//
//  LoginVC.swift
//  TodosApp_Exam
//
//  Created by Sherzod on 28/01/22.
//

import UIKit

class LoginVC: UIViewController {
    
    var isUser: Bool = false
    var user: UserData?
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var goBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        password.delegate = self

        for i in textFields! {
            i.layer.borderColor = UIColor.systemGray6.cgColor
            i.layer.borderWidth = 4
            i.layer.cornerRadius = 5
        }
    }

    @IBAction func textFieldChanged(_ sender: Any) {
        
        if firstName.text != "" {
            goBtn.backgroundColor = .green
        } else {
            goBtn.backgroundColor = .systemGray6
        }
    }
    
    @IBAction func goBtnPressed(_ sender: Any) {
        
        if firstName.text == "" {
            firstName.layer.borderColor = UIColor.red.cgColor
        } else {
            firstName.layer.borderColor = UIColor.systemGray6.cgColor
        }
        
        if email.text == "" {
            email.layer.borderColor = UIColor.red.cgColor
        } else {
            email.layer.borderColor = UIColor.systemGray6.cgColor
        }
        
        if password.text == "" {
            password.layer.borderColor = UIColor.red.cgColor
        } else {
            password.layer.borderColor = UIColor.systemGray6.cgColor
        }
        
        guard let fn = firstName.text else { return }
        guard let ln = lastName.text else { return }
        guard let e = email.text else { return }
        guard let p = password.text else { return }
        
        let vc = UserDataList(nibName: "UserDataList", bundle: nil)
        vc.user = UserData(firstName: fn, lastName: ln, email: e, password: p, tasks: [])
        
//        vc.user = UserData(firstName: UserDefaults.standard.string(forKey: "Name"), lastName: UserDefaults.standard.string(forKey: "Name"), email: UserDefaults.standard.string(forKey: "Name"), password: UserDefaults.standard.string(forKey: "Name"), tasks: [])
        
        
        vc.modalPresentationStyle = .fullScreen
        UserDefaults.standard.setValue(fn, forKey: "Name")
        
        self.present(vc, animated: true, completion: nil)
    }
}











extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if firstName.text == "" {
            firstName.layer.borderColor = UIColor.red.cgColor
        } else {
            firstName.layer.borderColor = UIColor.systemGray6.cgColor
        }
        
        if email.text == "" {
            email.layer.borderColor = UIColor.red.cgColor
        } else {
            email.layer.borderColor = UIColor.systemGray6.cgColor
        }
        
        if password.text == "" {
            password.layer.borderColor = UIColor.red.cgColor
        } else {
            password.layer.borderColor = UIColor.systemGray6.cgColor
        }
        
        if firstName.text != "" && email.text != "" && password.text != "" {
            let vc = UserDataList(nibName: "UserDataList", bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            vc.user = UserData(firstName: self.firstName.text!, lastName: self.lastName.text!, email: self.email.text!, password: self.password.text!, tasks: [])
            self.present(vc, animated: true, completion: nil)
            
        }
        
        return true
    }
    
}
