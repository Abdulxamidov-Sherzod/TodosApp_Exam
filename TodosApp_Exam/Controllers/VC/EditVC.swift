//
//  EditVC.swift
//  TodosApp_Exam
//
//  Created by Sherzod on 23/02/22.
//

import UIKit

protocol EditVCDelegate {
    func editData(task: Task, index: IndexPath)
    
}

class EditVC: UIViewController {
    
    var task: Task?
    var index: IndexPath!
    
    
    var delegate: EditVCDelegate?
    @IBOutlet weak var titleTf: UITextField!
    
    @IBOutlet weak var descrTf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTf.text = task?.title
        descrTf.text = task?.description
    
        
    }


    @IBAction func saveBtnPressed(_ sender: Any) {
        delegate?.editData(task: Task(title: titleTf.text!, description: descrTf.text!), index: index)
        
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
