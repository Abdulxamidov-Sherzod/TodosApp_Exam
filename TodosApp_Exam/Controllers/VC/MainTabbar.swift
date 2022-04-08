//
//  MainTabbar.swift
//  TodosApp_Exam
//
//  Created by Sherzod on 23/02/22.
//

import UIKit

class MainTabbar: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let vc1 = LoginVC(nibName: "LoginVC", bundle: nil)
        let tabbarItem1 = UITabBarItem(title: "Login", image: UIImage(systemName: "trash"), selectedImage: nil)
        vc1.tabBarItem = tabbarItem1
        
        let vc2 = UserDataList(nibName: "UserDataList", bundle: nil)
        let tabbarItem2 = UITabBarItem(title: "User", image: UIImage(systemName: "person"), selectedImage: nil)
        vc2.tabBarItem = tabbarItem2
        
        viewControllers = [vc1, vc2]
        
    }
    
}
