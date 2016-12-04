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
    @IBOutlet weak var scrollViewTagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.delegate = self
        tagListView.addTag("TagListView")
        tagListView.addTag("TEAChart")
        tagListView.addTag("To Be Removed")
        tagListView.addTag("To Be Removed")
        tagListView.addTag("Quark Shell")
        tagListView.removeTag("To Be Removed")
        tagListView.addTag("On tap will be removed").onTap = { [weak self] tagView in
            self?.tagListView.removeTagView(tagView)
        }
        
        let tagView = tagListView.addTag("gray")
        tagView.tagBackgroundColor = UIColor.gray
        tagView.onTap = { tagView in
            print("Don’t tap me!")
        }

        tagListView.insertTag("This should be the third tag", at: 2)
        
        biggerTagListView.delegate = self
        biggerTagListView.textFont = UIFont.systemFont(ofSize: 15)
        biggerTagListView.shadowRadius = 2
        biggerTagListView.shadowOpacity = 0.4
        biggerTagListView.shadowColor = UIColor.black
        biggerTagListView.shadowOffset = CGSize(width: 1, height: 1)
        biggerTagListView.addTag("Inboard")
        biggerTagListView.addTag("Pomotodo")
        biggerTagListView.addTag("Halo Word")
        biggerTagListView.alignment = .center
        
        biggestTagListView.delegate = self
        biggestTagListView.textFont = UIFont.systemFont(ofSize: 24)
        biggestTagListView.addTag("all")
        biggestTagListView.addTag("your")
        biggestTagListView.addTag("tag")
        biggestTagListView.addTag("are")
        biggestTagListView.addTag("belong")
        biggestTagListView.addTag("to")
        biggestTagListView.addTag("us")
        biggestTagListView.alignment = .right
        
        // This is an example of a TagListView inside a UIScrollView
        // You should fix the height of the UIScrollView
        // It only uses the default settings of a TagListView.
        
        scrollViewTagListView.delegate = self
        scrollViewTagListView.addTag("This")
        scrollViewTagListView.addTag("is")
        scrollViewTagListView.addTag("a")
        scrollViewTagListView.addTag("TagListView")
        scrollViewTagListView.addTag("within")
        scrollViewTagListView.addTag("a")
        scrollViewTagListView.addTag("scrollView.")
        scrollViewTagListView.addTag("If")
        scrollViewTagListView.addTag("the")
        scrollViewTagListView.addTag("data")
        scrollViewTagListView.addTag("does")
        scrollViewTagListView.addTag("not")
        scrollViewTagListView.addTag("fit")
        scrollViewTagListView.addTag("the")
        scrollViewTagListView.addTag("view")
        scrollViewTagListView.addTag("you")
        scrollViewTagListView.addTag("should")
        scrollViewTagListView.addTag("be")
        scrollViewTagListView.addTag("able")
        scrollViewTagListView.addTag("to")
        scrollViewTagListView.addTag("scroll")
        scrollViewTagListView.addTag("horizontally.")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}
