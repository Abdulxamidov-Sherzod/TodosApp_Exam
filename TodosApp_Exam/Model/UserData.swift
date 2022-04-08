//
//  UserData.swift
//  TodosApp_Exam
//
//  Created by Sherzod on 28/01/22.
//

import Foundation
import UIKit


struct UserData: Codable { //  Encodable, Decodable {
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var tasks: [Task]
}


struct Task: Codable {
    
    var title: String
    var description: String
    var isDone: Bool = false

}
