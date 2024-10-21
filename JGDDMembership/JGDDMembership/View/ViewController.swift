//
//  ViewController.swift
//  JGDDMembership
//
//  Created by minsong kim on 10/21/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
   
    
    var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
            
        return tableView
    }()
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.tableView = UITableView(frame: CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ""
    }
    
    
}



