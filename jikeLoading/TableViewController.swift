//
//  TableViewController.swift
//  jikeLoading
//
//  Created by Josscii on 16/5/19.
//  Copyright © 2016年 Josscii. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var jkloading: JKLoaingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        jkloading = JKLoaingView(frame: CGRect(x: 375/2 - 22.5, y: -44, width: 45, height: 45))
        
        tableView.addSubview(jkloading)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "row \(indexPath.row)"
        
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.y)
        
        if scrollView.contentInset.top != 124 && !jkloading.isLoading {
            jkloading.fillPercent = min(1 - (124 + scrollView.contentOffset.y) / 60, 1)
        }
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y <= -124 {
            scrollView.contentInset.top = 124
        }
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= -124 {
            if !jkloading.isLoading {
                jkloading.startLoading()
            }
        }
    }
}
