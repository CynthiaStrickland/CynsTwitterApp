//
//  TweetTableViewController.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class TweetTableViewController: UIViewController, UITableViewDataSource {

    var datasource = [Tweet](){
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tweetTitleLabel: UILabel!
    @IBOutlet weak var tweetCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()                     //Do I really need this since I have a property observer?
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    //MARK:     ************  TABLEVIEW **************
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath)
        let theTweet = self.datasource[indexPath.row]
        cell.textLabel?.text = theTweet.text
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            datasource.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }
}
