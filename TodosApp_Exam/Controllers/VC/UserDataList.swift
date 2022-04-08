//
//  UserDataList.swift
//  TodosApp_Exam
//
//  Created by Sherzod on 28/01/22.
//

import UIKit


class UserDataList: UIViewController, EditVCDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var sortedBtn: UIButton!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "UserDataTVC", bundle: nil), forCellReuseIdentifier: "UserDataTVC")
        }
    }
    
    var user : UserData?
    var sortedArray: [Task] = []
    var filteredArray: [Task] = []
    var index: IndexPath!
    var isSorted = false
    var isFiltered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //   MARK: - UserDefaults get value -
//        let tit = UserDefaults.standard.string(forKey: "title")
//        let desc = UserDefaults.standard.string(forKey: "description")
//        user!.tasks =  [Task(title: tit ?? "", description: desc ?? "")]
        //   MARK: --------------------------
        let tttt = UserDefaults.standard.string(forKey: "Name") ?? ""
        print(tttt)
        user = UserData(firstName: tttt, lastName: tttt, email: tttt, password: tttt, tasks: [])
        firstNameLbl.text = UserDefaults.standard.string(forKey: "Name") ?? ""
        
        
    }
    
    
    @IBAction func removeBtn(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "Name")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.decodeTasks()
        
    }
    
    
    private func encodeTasks() {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user?.tasks) {
            UserDefaults.standard.setValue(encoded, forKey: "MYTASKS")
            
        }
        
    }
    
    private func decodeTasks() {
        
        if let decodeTasks = UserDefaults.standard.object(forKey: "MYTASKS") as? Data {
            
            let decoder = JSONDecoder()
            if let tasks = try? decoder.decode([Task].self, from: decodeTasks) {
                self.user?.tasks = tasks
                tableView.reloadData()
            
            }
        }
    }
    
    
    
   
    @IBAction func alertBtnTapped(_ sender: Any) {
        self.showAlert()
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        let vc = TaskVC(nibName: "TaskVC", bundle: nil)

        
        vc.addNew = { task in
            
            if let newTask = task {
                
                //   MARK: - UserDefaults set value -
                
                UserDefaults.standard.setValue(newTask.title, forKey: "title")
                UserDefaults.standard.setValue(newTask.description, forKey: "description")
                //   MARK: --------------------------
                
                
                
                self.user?.tasks.append(newTask)
                self.tableView.reloadData()
                self.encodeTasks()
            }
            
        }
       
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    func isDoneBtn(row: Int, isdone: Bool) {
        tableView.reloadData()
    }
    func isd(isdone: Bool, row: Int) {
        user!.tasks[row].isDone = isdone
    }
    
    func editData(task: Task, index: IndexPath) {
        
        if isSorted == false {
            
            user!.tasks[index.row].title = task.title
            user!.tasks[index.row].description = task.description
        } else {
            sortedArray[index.row].title = task.title
            sortedArray[index.row].description = task.description
        }
        tableView.reloadData()
    }

    @IBAction func sortedBtnTapped(_ sender: Any) {
        
        isSorted = !isSorted
        isFiltered = false
        
        if isSorted {
            sortedBtn.setTitle("X", for: .normal)
        } else {
            sortedBtn.setTitle("Sort", for: .normal)
        }
        sortedArray = user!.tasks.sorted { title1, title2 in
            
            return title1.title < title2.title
        }
        tableView.reloadData()
    }
    
    func shareTapped(title: String) {
        
        do {
            let objectsToShare: [Any] = [title]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}

//MARK: - TaskVCDelegate
//extension UserDataList: TaskVCDelegate {
//    func addDataTasks(task: Task) {
//        user!.tasks.append(task)
//        tableView.reloadData()
//    }
//}

//MARK: - UserDataTVCDelegate
extension UserDataList: UserDataTVCDelegate {
    func trashTapped(index: IndexPath) {
        
        user!.tasks.remove(at: index.row)
        tableView.deleteRows(at: [IndexPath(row: index.row, section: 0)], with: .left)
        tableView.reloadData()
    }
    
    func checkTapped(index: IndexPath) {
        user!.tasks[index.row].isDone = !user!.tasks[index.row].isDone
        tableView.reloadData()
    }
}

//MARK: - Table View
extension UserDataList: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { [self] _ in
                self.shareTapped(title: user!.tasks[indexPath.row].title)
            }
            
            let editAction = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { _ in
                
                let vc = EditVC(nibName: "EditVC", bundle: nil)
                vc.modalPresentationStyle = .overFullScreen
                
                if self.isSorted == false {
                    
                    vc.task = self.user!.tasks[indexPath.row]
                    vc.index = indexPath
                } else {
                    
                    vc.task = self.sortedArray[indexPath.row]
                    vc.index = indexPath
                }
                vc.delegate = self
                tableView.reloadData()
                self.present(vc, animated: true, completion: nil)
            }
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                
                if !self.isSorted {
                    
                    self.user!.tasks.remove(at: indexPath.row)
                    tableView.reloadData()
                } else {
                    self.user!.tasks.remove(at: indexPath.row)
                    self.sortedArray.remove(at: indexPath.row)
                    tableView.reloadData()
                }
                
            }
            return UIMenu(title: "", children: [shareAction, editAction, deleteAction])
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.setupBackground(with: "Hozirda qiladigan ishlar yo'q", count: user?.tasks.count ?? 0)
        
        if isFiltered {
            
            return filteredArray.count
        } else {
            return user?.tasks.count ?? 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataTVC", for: indexPath) as? UserDataTVC else { return UITableViewCell() }
        
        if isFiltered {
            cell.uptadeCell(task: filteredArray[indexPath.row], index: indexPath)
        } else if isSorted {
            cell.uptadeCell(task: sortedArray[indexPath.row], index: indexPath)
        } else {
            cell.uptadeCell(task: user!.tasks[indexPath.row], index: indexPath)
        }
        
        self.index = indexPath
        cell.trashDelegate = self
        cell.checkDelegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0 {
            
            let vc = WebviewVC(nibName: "WebviewVC", bundle: nil)
            vc.url = URL(string: "https://www.apple.com/")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            
        } else if indexPath.row == 1 {
            
            let vc = WebviewVC(nibName: "WebviewVC", bundle: nil)
            vc.url = URL(string: "https://www.instagram.com/")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        } else if indexPath.row == 2 {
            
            let vc = WebviewVC(nibName: "WebviewVC", bundle: nil)
            vc.url = URL(string: "https://www.youtube.com/")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        } else if indexPath.row == 3 {
            
            let vc = WebviewVC(nibName: "WebviewVC", bundle: nil)
            vc.url = URL(string: "https://lms.tuit.uz/")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        } else if indexPath.row == 4 {
            
            let vc = WebviewVC(nibName: "WebviewVC", bundle: nil)
            vc.url = URL(string: "https://www.google.com/")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
       
    }
    
}




//MARK: - UITable View
extension UITableView {
    func setupBackground(with text : String, count : Int) {
        if count == 0 {
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width - 40, height: 100))
            lbl.center = self.center
            lbl.text = text
            lbl.textAlignment = .center
            lbl.textColor = .gray
            lbl.font = UIFont.italicSystemFont(ofSize: 20)
            lbl.numberOfLines = 0
            self.backgroundView = lbl
        } else {
            self.backgroundView = nil
        }
    }
}

//MARK: - UISearchBarDelegate
extension UserDataList: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSorted = false
        isFiltered = true
        
        if isFiltered {
            
            filteredArray = user!.tasks.filter { filter in
                return filter.title.lowercased().hasPrefix(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
}

extension UserDataList {
    
    func showAlert() {
        
        let alertVC = UIAlertController(title: "Salom", message: "Nma gap", preferredStyle: .alert)
        
        alertVC.addTextField { tf1 in
            tf1.placeholder = "Title"
            
        }
        alertVC.addTextField { tf2 in
            tf2.placeholder = "Descriptions"
        }
        
        let okAction = UIAlertAction(title: "ok", style: .default) { _ in
            
            self.user!.tasks.append(Task(title: (String((alertVC.textFields?.first?.text)!)), description: (String((alertVC.textFields?.last?.text)!))))
            self.tableView.reloadData()
        
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            
        }
        
        alertVC.addAction(okAction)
        alertVC.addAction(deleteAction)
        present(alertVC, animated: true, completion: nil)
        
    }
    
}












