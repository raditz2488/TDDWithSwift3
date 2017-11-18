//
//  ItemManager.swift
//  ToDo
//
//  Created by Rohan Bhale on 28/05/17.
//  Copyright © 2017 RB. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    
    var toDoPathURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentURL = fileURLs.first else {
            print("Something went wrong. Documents url could not be found")
            fatalError()
        }
        
        return documentURL.appendingPathComponent("toDoItems.plist")
    }
    
    var donePathURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentURL = fileURLs.first else {
            print("Something went wrong. Documents url could not be found")
            fatalError()
        }
        
        return documentURL.appendingPathComponent("doneItems.plist")
    }
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: .UIApplicationWillResignActive, object: nil)
        
        if let nsToDiItems = NSArray(contentsOf: toDoPathURL)
        {
            for dict in nsToDiItems {
                if let toDoItem = ToDoItem(dict: dict as! [String:Any]) {
                    toDoItems.append(toDoItem)
                }
            }
        }
        
        if let nsDoneItems = NSArray(contentsOf: donePathURL)
        {
            for dict in nsDoneItems {
                if let toDoItem = ToDoItem(dict: dict as! [String:Any]) {
                    doneItems.append(toDoItem)
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        save()
    }
    
    func add(_ item: ToDoItem) {
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
    }
    
    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    func checkItem(at index: Int) {
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    
    func uncheckItem(at index: Int) {
        let item = doneItems.remove(at: index)
        toDoItems.append(item)
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }
    
    func removeAll() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
    
    func save() {
        let nsToDoItems = toDoItems.map{ $0.plistDict }
        if nsToDoItems.count > 0 {
            do {
                let plistData = try PropertyListSerialization.data(fromPropertyList: nsToDoItems, format: .xml, options: PropertyListSerialization.WriteOptions(0))
                try plistData.write(to: toDoPathURL, options: Data.WritingOptions.atomic)
            } catch {
                print(error)
            }
        }else {
            try? FileManager.default.removeItem(at: toDoPathURL)
        }
        
        
        
        let nsDoneItems = doneItems.map{ $0.plistDict }
        if nsDoneItems.count > 0 {
            do {
                let plistData = try PropertyListSerialization.data(fromPropertyList: nsDoneItems, format: .xml, options: PropertyListSerialization.WriteOptions(0))
                try plistData.write(to: donePathURL, options: Data.WritingOptions.atomic)
            } catch {
                print(error)
            }
        }else {
            try? FileManager.default.removeItem(at: donePathURL)
            return
        }
    }
}
