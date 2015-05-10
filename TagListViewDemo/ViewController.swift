//
//  ViewController.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tagListView.addTag("all")
        tagListView.addTag("your")
        tagListView.addTag("tag")
        tagListView.addTag("are")
        tagListView.addTag("belong")
        tagListView.addTag("to")
        tagListView.addTag("us")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

