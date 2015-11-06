//
//  ViewController.swift
//  LazyLoadTest
//
//  Created by admin on 02.11.15.
//  Copyright © 2015 iosOleksii. All rights reserved.
//

import UIKit

private let useAutosizingCells = true

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let cellIdentifier = "Cell"
    private var currentPage = 0
    private var numPages = 0
    private var stories = [StoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if useAutosizingCells && tableView.respondsToSelector("layoutMargins") {
            tableView.estimatedRowHeight = 88
            tableView.rowHeight = UITableViewAutomaticDimension
        }
        
        // Set custom indicator
        tableView.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRectMake(0, 0, 24, 24))
        // Set custom indicator margin
        tableView.infiniteScrollIndicatorMargin = 40
        // Add infinite scroll handler
        tableView.addInfiniteScrollWithHandler { [weak self] (scrollView) -> Void in
            self?.fetchData() {
                scrollView.finishInfiniteScroll()
            }
        }
        fetchData(nil)
    }
    
    // MARK: - Private
    private func apiURL(numHits: Int, page: Int) -> NSURL {
        let string = "https://hn.algolia.com/api/v1/search_by_date?tags=story&hitsPerPage=\(numHits)&page=\(page)"
        return NSURL(string: string)!
    }
    
    private func fetchData(handler: ((Void) -> Void)?) {
        let hits = Int(CGRectGetHeight(tableView.bounds)) / 44
        let requestURL = apiURL(hits, page: currentPage)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(requestURL, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.handleResponse(data, response: response, error: error)
                
                UIApplication.sharedApplication().stopNetworkActivity()
                
                handler?()
            });
        })
        
        UIApplication.sharedApplication().startNetworkActivity()
        
        // I run task.resume() with delay because my network is too fast
        let delay = (stories.count == 0 ? 0 : 2) * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            task.resume()
        })
    }
    
    private func handleResponse(data: NSData!, response: NSURLResponse!, error: NSError!) {
        if let _ = error {
            showAlertWithError(error)
            return;
        }
        
        var jsonError: NSError?
        var responseDict: [String: AnyObject]?
        
        do {
            responseDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
        } catch {
            jsonError = NSError(domain: "JSONError", code: 1, userInfo: [ NSLocalizedDescriptionKey: "Failed to parse JSON." ])
        }
        
        if let jsonError = jsonError {
            showAlertWithError(jsonError)
            return
        }
        
        if let pages = responseDict?["nbPages"] as? NSNumber {
            numPages = pages as Int
        }
        
        if let results = responseDict?["hits"] as? [[String: AnyObject]] {
            currentPage++
            
            for i in results {
                stories.append(StoryModel(i))
            }
            
            tableView.reloadData()
        }
    }
    
    private func showAlertWithError(error: NSError) {
        let alert = UIAlertController(title: NSLocalizedString("Error fetching data", comment: ""), message: error.localizedDescription, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .Cancel, handler: { (action) -> Void in
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: .Default, handler: { (action) -> Void in
            self.fetchData(nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let story = stories[indexPath.row]
        
        cell.textLabel?.text = story.title
        cell.detailTextLabel?.text = story.author
        
        if useAutosizingCells && tableView.respondsToSelector("layoutMargins") {
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.numberOfLines = 0
        }
        return cell
    }
}