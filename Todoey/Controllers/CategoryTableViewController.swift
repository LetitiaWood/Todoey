//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Letitia Wu on 2019/10/4.
//  Copyright © 2019 Letitia Wu. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: UITableViewController {

    lazy var realm:Realm = {
        return try! Realm()
    }()
//    let realm = try! Realm()
    var categories : Results<Category>?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    // MARK: - Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    // MARK: - Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    
    
    // MARK: - Data Manipulation Methods
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
            return cell
        }

    // MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action =  UIAlertAction(title: "Add Category", style: .default) { (action) in
        //            what will happen when uialert is clicked
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
                
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func save(category : Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving categories \(error)")
        }
        
        self.tableView.reloadData()
    }
    
     func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
        }
}
