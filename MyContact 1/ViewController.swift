//
//  ViewController.swift
//  MyContact 1
//
//  Created by webstudent on 10/19/15.
//  Copyright © 2015 James Backstrom. All rights reserved.
//

import UIKit
import CoreData
    
    class ViewController: UIViewController {
        
        
        let managedObjectContext =
        (UIApplication.sharedApplication().delegate
            as! AppDelegate).managedObjectContext
        
        var contactdb:NSManagedObject!
        
        @IBAction func btnBack(sender: AnyObject) {
            
            self.dismissViewControllerAnimated(false, completion: nil)
        }
        
        @IBOutlet weak var fullname: UITextField!
        @IBOutlet weak var email: UITextField!
        @IBOutlet weak var phone: UITextField!
        @IBOutlet weak var address: UITextField!
        @IBOutlet weak var gender: UITextField!
        @IBOutlet weak var btmSave: UIButton!
        
        @IBOutlet weak var status: UILabel!
        @IBAction func btmSave(sender: AnyObject) {
            
            if (contactdb != nil)
            {
                
                contactdb.setValue(fullname.text, forKey: "fullname")
                contactdb.setValue(email.text, forKey: "email")
                contactdb.setValue(phone.text, forKey: "phone")
                contactdb.setValue(address, forKey: "address")
                contactdb.setValue(gender, forKey: "gender")
                
            }
            else
            {
                let entityDescription =
                NSEntityDescription.entityForName("Contact",inManagedObjectContext: managedObjectContext)
                
                let contact = Contact(entity: entityDescription!,
                    insertIntoManagedObjectContext: managedObjectContext)
                
                contact.fullname = fullname.text!
                contact.email = email.text!
                contact.phone = phone.text!
                contact.address = address.text!
                contact.gender = gender.text!
                
            }
            var error: NSError?
            do {
                try managedObjectContext.save()
            } catch let error1 as NSError {
                error = error1
            }
            
            if let err = error {
                status.text = err.localizedFailureReason
            } else {
                self.dismissViewControllerAnimated(false, completion: nil)
                
            }
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if (contactdb != nil)
            {
                fullname.text = contactdb.valueForKey("fullname") as? String
                email.text = contactdb.valueForKey("email") as? String
                phone.text = contactdb.valueForKey("phone") as? String
                address.text = contactdb.valueForKey("address") as? String
                gender.text = contactdb.valueForKey("gender") as? String
                btmSave.setTitle("Update", forState: UIControlState.Normal)
            }
            fullname.becomeFirstResponder()
            
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
            
            view.addGestureRecognizer(tap)
            
            
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            
        }
        
                override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            if let touch = touches.first as UITouch! {
                DismissKeyboard()
            }
            super.touchesBegan(touches , withEvent:event)
        }
        
       
        func DismissKeyboard(){
            
            fullname.endEditing(true)
            email.endEditing(true)
            phone.endEditing(true)
            address.endEditing(true)
            gender.endEditing(true)
        }
        
        func textFieldShouldReturn(textField: UITextField!) -> Bool     {
            textField.resignFirstResponder()
            return true;
        }
        
        
        
        
}


















































