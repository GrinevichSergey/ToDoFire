//
//  Task.swift
//  ToDoFire
//
//  Created by Сергей Гриневич on 08/04/2019.
//  Copyright © 2019 Green. All rights reserved.
//

import Foundation
import Firebase

struct Task {
    let title: String
    let userID: String
    let ref: DatabaseReference?
    var completed: Bool = false
    
    init(title: String, userID: String) {
        self.title = title
        self.userID = userID
        self.ref = nil
        
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotvalue = snapshot.value as! [String: AnyObject ]
        title = snapshotvalue["title"] as! String
        userID = snapshotvalue["userID"] as! String
        completed = snapshotvalue["completed"] as! Bool
        ref = snapshot.ref
        
    }
    
    func converToDictionary() -> Any {
        return ["title": title, "userID": userID, "completed": completed]
    }
    
}
