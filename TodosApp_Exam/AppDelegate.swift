//
//  AppDelegate.swift
//  TodosApp_Exam
//
//  Created by Sherzod on 28/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var todoApp: [Task] = []
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        
        
        if UserDefaults.standard.string(forKey: "Name") == nil {
            
            
            let vc = LoginVC(nibName: "LoginVC", bundle: nil)
            
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        
        
        } else {
            let vc = UserDataList(nibName: "UserDataList", bundle: nil)
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }

        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate isladi")
    }
    
}

