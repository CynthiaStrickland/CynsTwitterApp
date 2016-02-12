//
//  TweetTableViewController.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import Foundation

class TweetTableViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var refreshBarButton: UIBarButtonItem!
    
    var refreshControl : UIRefreshControl?
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
        
        self.refreshBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "getTweets")
        self.navigationItem.rightBarButtonItem = self.refreshBarButton
        
//        self.spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
//        self.spinner.hidesWhenStopped = true
//        
//        self.refresh.addTarget(self, action: "pullToRefresh", forControlEvents: UIControlEvents.ValueChanged)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: "refreshTweets:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl!)
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
