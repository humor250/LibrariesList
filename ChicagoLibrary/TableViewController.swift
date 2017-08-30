//
//  TableViewController.swift
//  ChicagoLibrary
//
//  Created by Karl on 2017/8/3.
//  Copyright © 2017年 butterfly. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: DBController.LIBRARY_ADDED_NOTIFICATION, object: nil, queue: nil){ notification in
            
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DBController.sharedLibraries().count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
     
        let librariesArray:Array = DBController.sharedLibraries()
        
        let library:MapPin = librariesArray[indexPath.row] as! MapPin
        cell.textLabel?.text = library.title
     
        return cell
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
        let viewController = segue.destination as! DetailViewController
            
        let librariesArray:Array = DBController.sharedLibraries()
            
        let library:MapPin = librariesArray[indexPath.row] as! MapPin
            // your new view controller should have property that will store passed value
            
        viewController.currentLibrary = library

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

