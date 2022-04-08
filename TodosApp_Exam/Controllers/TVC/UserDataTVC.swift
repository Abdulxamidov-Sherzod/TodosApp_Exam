//
//  UserDataTVC.swift
//  TodosApp_Exam
//
//  Created by Sherzod on 28/01/22.
//

import UIKit

protocol UserDataTVCDelegate {
    func trashTapped(index : IndexPath)
    func checkTapped(index : IndexPath)
}


class UserDataTVC: UITableViewCell {

    var user : UserData?
    var index: IndexPath!
    var isDone : Task?
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var isDoneBtn: UIButton!
    @IBOutlet weak var colorView: UIView!
    var trashDelegate : UserDataTVCDelegate?
    var checkDelegate : UserDataTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func uptadeCell(task : Task, index : IndexPath) {
        self.index = index
        titleLbl.text! = task.title
        descriptionLbl.text! = task.description
//        colorView.backgroundColor! = task.priaroty
        
        isDoneBtn.setImage(UIImage(systemName: task.isDone ? "checkmark.circle" : "circle"), for: .normal)
    }
    
    
    @IBAction func isDone(_ sender: Any) {
        checkDelegate?.checkTapped(index: index)
    }
    
    @IBAction func removeRow(_ sender: Any) {
        trashDelegate?.trashTapped(index: index)
    }
    
    
}
