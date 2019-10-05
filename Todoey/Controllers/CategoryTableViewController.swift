//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Letitia Wu on 2019/10/4.
//  Copyright © 2019 Letitia Wu. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    // MARK: - Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    // MARK: - Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    
    
    
    // MARK: - Data Manipulation Methods
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            cell.textLabel?.text = categoryArray[indexPath.row].name
            return cell
        }

    // MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action =  UIAlertAction(title: "Add Category", style: .default) { (action) in
        //            what will happen when uialert is clicked
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategories()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
                
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error saving categories \(error)")
        }
        
        self.tableView.reloadData()
    }
    
     func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
            do {
               categoryArray = try context.fetch(request)
            } catch {
                print("Error loading categories \(error)")
            }
            tableView.reloadData()
        }

    
    

}
