//
//  TasksViewController.swift
//  ToDoFire
//
//  Created by Сергей Гриневич on 06/04/2019.
//  Copyright © 2019 Green. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func addTaped(_ sender: UIBarButtonItem){
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
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
}
