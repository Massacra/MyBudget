//
//  ChooseSubCategoryViewController.swift
//  My Budget
//
//  Created by MacUSER on 8.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class ChooseSubCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var subCategoryTableVIew: UITableView! 
    
    let subCategoryCellId = "subCategoryId"
    
    var selectedCategory: Int!
    var subcategoriesArray: [(Int,String)]!     //all subcategories from db in tuples PK and name
    var selectedSubcategory: (Int,String)!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (subcategoriesArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = subCategoryTableVIew?.dequeueReusableCell(withIdentifier: subCategoryCellId) as? SubCategoryTableViewCell {
            cell.subCategoryLabel.text  = subcategoriesArray[indexPath.row].1
            return cell
        }
        return UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
      subcategoriesArray = DBManager.singleton.loadSubCategories(categoryId: selectedCategory+1)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == unwindToPopUpViewId{
            let destination = segue.destination as? PopUpViewController
            destination?.selectedSubCategory = selectedSubcategory
            destination?.subCategoryLabel.textColor = UIColor.white
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSubcategory = subcategoriesArray[indexPath.row]
        performSegue(withIdentifier: unwindToPopUpViewId, sender: self)
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
