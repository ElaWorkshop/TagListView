//
//  TagTableViewController.swift
//  TagListViewDemo
//
//  Created by arnaud on 23/11/16.
//  Copyright © 2016 Ela. All rights reserved.
//

import UIKit

class TagTableViewController: UITableViewController, TagListViewDelegate {


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    private var tags = ["This", "is", "a", "set", "of", "tags", "in", "a", "tableViewCell", ".", "There", "are", "a", "lot", "of", "tags", "defined", "here", "in", "order", "to", "show", "the", "dynamic", "cell", "height", "LAST ONE"]
    
    private var editMode = false
    
    fileprivate struct Storyboard {
        static let TagListViewCellIdentifier = "TagListView Cell"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TagListViewCellIdentifier, for: indexPath) as! TagsTableViewCell
        cell.tagList = tags
        cell.tagListView?.delegate = self
        return cell
    }
    
    // This button allows to toggle between editMode and non-editMode
    @IBAction func editBarButtonTapped(_ sender: UIBarButtonItem) {
        editMode = !editMode
        tableView.reloadData()
    }
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // See http://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights#18746930
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // This repaints the view, so the cells get the right height.
        // This is not always needed, try it out.
        tableView.layoutIfNeeded()
    }

}
