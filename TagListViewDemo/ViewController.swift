//
//  ViewController.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TagListViewDelegate {

    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var biggerTagListView: TagListView!
    @IBOutlet weak var biggestTagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.delegate = self
        tagListView.addTag("TagListView")
        tagListView.addTag("TEAChart")
        tagListView.addTag("To Be Removed")
        tagListView.addTag("To Be Removed")
        tagListView.addTag("Quark Shell")
        tagListView.removeTag("To Be Removed")
        tagListView.addTag("On tap will be removed").onTap = { tagView in
            self.tagListView.removeTagView(tagView)
        }
        
        let tagView = tagListView.addTag("gray")
        tagView.tagBackgroundColor = UIColor.grayColor()
        tagView.onTap = { tagView in
            println("Don’t tap me!")
        }
        
        biggerTagListView.delegate = self
        biggerTagListView.textFont = UIFont.systemFontOfSize(15)
        biggerTagListView.addTag("Inboard")
        biggerTagListView.addTag("Pomotodo")
        biggerTagListView.addTag("Halo Word")
        
        biggestTagListView.delegate = self
        biggestTagListView.textFont = UIFont.systemFontOfSize(24)
        biggestTagListView.addTag("all")
        biggestTagListView.addTag("your")
        biggestTagListView.addTag("tag")
        biggestTagListView.addTag("are")
        biggestTagListView.addTag("belong")
        biggestTagListView.addTag("to")
        biggestTagListView.addTag("us")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tagPressed(title: String, tagView: TagView, sender: TagListView) {
        println("Tag pressed: \(title), \(sender)")
        
        tagView.selected = !tagView.selected
    }
}

