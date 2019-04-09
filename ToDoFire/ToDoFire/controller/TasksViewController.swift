//
//  TasksViewController.swift
//  ToDoFire
//
//  Created by Сергей Гриневич on 06/04/2019.
//  Copyright © 2019 Green. All rights reserved.
//

import UIKit
import Firebase

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: Users!
    var ref: DatabaseReference!
    var tasks = Array<Task>()
    
    @IBOutlet weak var tableview: UITableView!
    @IBAction func singOutTapped(_ sender: UIBarButtonItem) {
        do{
           try  Auth.auth().signOut()
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        dismiss(animated: true, completion: nil)
       
    }
    
    @IBAction func addTaped(_ sender: UIBarButtonItem)
    {
        let alrt = UIAlertController(title: "New task", message: "Add new task", preferredStyle: .alert)
        alrt.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textField = alrt.textFields?.first, textField.text != "" else {return}
         
            let task = Task(title: textField.text!, userID: (self?.user.id)!)
            let tasfRef = self?.ref.child(task.title.lowercased())
            tasfRef?.setValue(task.converToDictionary())
        }
        
        let cancel = UIAlertAction(title: "Chancel", style: .cancel, handler: nil)
        alrt.addAction(save)
        alrt.addAction(cancel)
        
        present(alrt, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = "This is cell number = \(indexPath.row)"
        cell.textLabel?.textColor = .white
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUser = Auth.auth().currentUser else {return}
        user = Users(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(user.id).child("tasks")
    }
    
    
    
    
}
