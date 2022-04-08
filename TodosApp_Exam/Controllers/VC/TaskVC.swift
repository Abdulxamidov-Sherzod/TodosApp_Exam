//
//  TaskVC.swift
//  TodosApp_Exam
//
//  Created by Sherzod on 28/01/22.
//

import UIKit



class TaskVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLbl: UITextField!
    
    var addNew: ((Task?) ->())?
    
    @IBOutlet weak var descriptionLbl: UITextField!
    @IBOutlet weak var colorBtn: UIButton!

    var isColor = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLbl.layer.borderColor = UIColor.systemGray6.cgColor
        titleLbl.layer.borderWidth = 4
        titleLbl.layer.cornerRadius = 5
        descriptionLbl.layer.borderColor = UIColor.systemGray6.cgColor
        descriptionLbl.layer.borderWidth = 4
        descriptionLbl.layer.cornerRadius = 5
        
    }
    
   
    
    override func viewDidLayoutSubviews() {
        containerView.layer.masksToBounds = false
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOpacity = 0.4
    }


    @IBAction func addBtnPressed(_ sender: Any) {
        if titleLbl.text == "" {
            titleLbl.layer.borderColor = UIColor.red.cgColor
        } else {
            titleLbl.layer.borderColor = UIColor.systemGray6.cgColor
        }
        
        if descriptionLbl.text == "" {
            descriptionLbl.layer.borderColor = UIColor.red.cgColor
        } else {
            descriptionLbl.layer.borderColor = UIColor.systemGray6.cgColor
        }
        
        if titleLbl.text! != "" && descriptionLbl.text! != "" {
            
            let new = Task(title: titleLbl.text!, description: descriptionLbl.text!)
            addNew?(new)
            
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func colorBtnPressed(_ sender: Any) {
        if colorBtn.backgroundColor == .gray {
            colorBtn.backgroundColor = .red
        }
        else if isColor {
            colorBtn.backgroundColor = .green
            isColor = !isColor
        }
        else if !isColor {
            colorBtn.backgroundColor = .gray
            isColor = !isColor
        }
        
    }
    
}
