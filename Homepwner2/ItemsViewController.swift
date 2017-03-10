//
//  ItemsViewController.swift
//  Homepwner2
//
//  Created by Timothy Huang on 3/7/17.
//  Copyright © 2017 Timothy Huang. All rights reserved.
//

import Foundation
import UIKit


class ItemsViewController: UITableViewController
{
    var itemStore: ItemStore!

    
    // Editing button 
    @IBAction func toggleEditingMode(sender: AnyObject)
    {
        if isEditing
        {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }
        
        else
        {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    
    }
    
    // Add button
    @IBAction func addNewItem(sender: AnyObject)
    {
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the array›
        if let index = itemStore.allItems.index(of: newItem)
        {
            let indexPath = NSIndexPath(row: index, section: 0)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)

        }
    }
    
    // Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        // If the table view is asking to commit a delete command
        if editingStyle == .delete
        {
            let item = itemStore.allItems[indexPath.row]
            
            
            // *************************Display user alert with .ActionSheet
            let title = "Delete \(item.name) ?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler : nil)
            ac.addAction(cancelAction)
            
            //let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: (UIAlertAction) -> Void)? = nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(ACTION) -> Void in
                
                // Remove the item from the store
                self.itemStore.removeItem(item: item)

                // Remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            })
            
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    } // end delete

   
    // Move 
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // Update the model
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    
    
    // Do this when the view first loads
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        // Create Content Inset padding 
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
    }
    
    // numberOfRowsInSection = how many rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemStore.allItems.count
    }
    
    
    
    // cellForRowAt = which row and what content 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Create an instance of UITableViewCell, with default appearance
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
        
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
        
    } // end func

} // end class
