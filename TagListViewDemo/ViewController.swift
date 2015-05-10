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
    @IBOutlet weak var biggerTagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tagListView.addTag("TagListView")
        tagListView.addTag("TEAChart")
        tagListView.addTag("Quark Shell")
        tagListView.addTag("miracle-board")
        
        biggerTagListView.textFont = UIFont.systemFontOfSize(15)
        biggerTagListView.addTag("Inboard")
        biggerTagListView.addTag("Pomotodo")
        biggerTagListView.addTag("Halo Word")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

