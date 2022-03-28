//
//  ViewController.swift
//  TodoListApp
//
//  Created by Kevin Stradtman on 3/28/22.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var importantCheckBox: NSButton!
    @IBOutlet var textField: NSTextField!
    
    var todoItems: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getTodoItems()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func getTodoItems() {
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            do {
                todoItems = try context.fetch(TodoItem.fetchRequest())
                print(todoItems.count)
            } catch {
                
            }
        }
    }

    @IBAction func submitClicked(_ sender: Any) {
        if textField.stringValue != "" {
            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let todoItem = TodoItem(context: context)
                todoItem.name = textField.stringValue
                if importantCheckBox.state == .off {
                    todoItem.important = false
                } else {
                    todoItem.important = true
                }
                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                textField.stringValue = ""
                importantCheckBox.state = .off
                getTodoItems()
            }
        }
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return todoItems.count
    }
}

