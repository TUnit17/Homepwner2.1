//
//  ItemStore.swift
//  Homepwner2
//
//  Created by Timothy Huang on 3/7/17.
//  Copyright © 2017 Timothy Huang. All rights reserved.
//

import Foundation
import UIKit


class ItemStore
{
    var allItems = [Item]()
    
    
    // Create item
    func createItem() -> Item
    {
        let newItem = Item(random: true)
        allItems.append(newItem)
        
        return newItem
    
    
    } // end func
    
    
    // Remove the item from the item store
    func removeItem(item: Item)
    {
        if let index = allItems.index(of: item)
        {
            allItems.remove(at: index)
        }
    }
    
    // Move items
    func moveItemAtIndex(fromIndex: Int, toIndex: Int)
    {
        if fromIndex == toIndex
        {
            return
        }
        
        // Get reference to object being moved so you can reinsert it 
        let movedItem = allItems[fromIndex]
        
        // Remove item from array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    
    
    // create 5 items at first
    init()
    {
        for _ in 0..<5
        {
            createItem()
            
        }
    
    }
    

} // end class
