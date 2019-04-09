//
//  User.swift
//  ToDoFire
//
//  Created by Сергей Гриневич on 08/04/2019.
//  Copyright © 2019 Green. All rights reserved.
//

import Foundation
import Firebase

struct Users {
    let id: String
    let email : String
   
    
    init(user: User) {
        self.id = user.uid
        self.email = user.email!
        
    }
}
