//
//  ContactTableViewController.swift
//  MyContact 1
//
//  Created by webstudent on 10/19/15.
//  Copyright © 2015 James Backstrom. All rights reserved.
//

import UIKit
import CoreData
import Foundation


class ContactTableViewController: UITableViewController {
    
    var contactArray = [NSManagedObject]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loaddb()
    }
   
    func loaddb()
    {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        
        let fetchRequest = NSFetchRequest(entityName:"Contact")
        
        
        var error: NSError?
        
        
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                contactArray = results
                tableView.reloadData()
            } else {
                print("Could not fetch \(error), \(error!.userInfo)")
            }
        } catch let error as NSError {
           
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactArray.count
     
        
    }
    
 
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier("Cell")
            as UITableViewCell!
        
        let person = contactArray[indexPath.row]
        cell.textLabel?.text = person.valueForKey("fullname") as! String?
        cell.detailTextLabel?.text = ">>"
        
        return cell
    }
    
   
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("You selected cell #\(indexPath.row)")
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext
            context.deleteObject(contactArray[indexPath.row])
            var error: NSError? = nil
            do {
                try context.save()
                loaddb()
            } catch let error1 as NSError {
                error = error1
                print("Unresolved error \(error)")
                abort()
            }
        }
        
    }
    
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "UpdateContacts" {
            if let destination = segue.destinationViewController as?
                ViewController {
                    if let SelectIndex = tableView.indexPathForSelectedRow?.row {
                        
                        let selectedDevice:NSManagedObject = contactArray[SelectIndex] as NSManagedObject
                        destination.contactdb = selectedDevice
                    }
            }
        }
    }
    
    
}

