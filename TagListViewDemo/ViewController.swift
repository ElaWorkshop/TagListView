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
    @IBOutlet var hetroTagView: TagListView!
    
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
        biggerTagListView.textFont = .systemFont(ofSize: 15)
        biggerTagListView.shadowRadius = 2
        biggerTagListView.shadowOpacity = 0.4
        biggerTagListView.shadowColor = UIColor.black
        biggerTagListView.shadowOffset = CGSize(width: 1, height: 1)
        biggerTagListView.addTag("Inboard")
        biggerTagListView.addTag("Pomotodo")
        biggerTagListView.addTag("Halo Word")
        biggerTagListView.alignment = .center
        
        biggestTagListView.delegate = self
        biggestTagListView.textFont = .systemFont(ofSize: 24)
        // it is also possible to add all tags in one go
        biggestTagListView.addTags(["all", "your", "tag", "are", "belong", "to", "us"])
        biggestTagListView.minWidth = 57
        biggestTagListView.alignment = .right
        
        //hetro tag view example. See the custom classes at the end of this file for how to override properties of tag views
        let htag1 = TestTagViewOne.init(title: "Custom 1")
        let htag2 = TestTagViewTwo.init(title: "Custom 2")
        let htag3 = TestTagViewTwo.init(title: "Two again")
        let htag4 = TestTagViewOne.init(title: "1 agn")
        let htag5 = TestTagViewThree.init(title: "custom class 3")
        
        //tag with attributed string example
        let attrTag = TestTagViewThree.init(title: "") //title does not matter because we set the attributed title later
        attrTag.tagAttributedTitle = NSAttributedString.init(string: "attributed title", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.strikethroughStyle : 2, NSAttributedString.Key.strokeColor : UIColor.magenta])
        
        hetroTagView.addTagViews([htag1, htag2, htag3, htag4, htag5])
        hetroTagView.insertTagView(attrTag, at: 3)
        
        
        //image tag example
        if #available(iOS 13.0, *) {
            var img = UIImage.init(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 20))!
            img = UIImage.init(named: "singer")! //comment out this line to see the sf symbol version work
            let attrStr = NSMutableAttributedString.init(string: "tag with img", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)])
            let atachment = NSTextAttachment()
            atachment.image = img
            attrStr.append(NSAttributedString.init(attachment: atachment))
            
            let imgtag = TestTagViewThree.init(title: "")
            imgtag.tagAttributedTitle = attrStr
            hetroTagView.addTagView(imgtag)
        } else {
            // this will work but we cant use sf symbols. Just use any other UIImage for your text attachment
        }
        
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
    
    class TestTagViewOne: TagView {
        override var tagBackgroundColor: UIColor{
            get{
                return .orange
            }
            set{}
        }
        
        override var textFont: UIFont{
            get{
                return .systemFont(ofSize: 20)
            }
            set{}
        }
    }
    
    class TestTagViewTwo: TagView {
        override var tagBackgroundColor: UIColor{
            get{
                return .purple
            }
            set{}
        }
        
        override var textFont: UIFont{
            get{
                return .boldSystemFont(ofSize: 18)
            }
            set{}
        }
    }
    
    class TestTagViewThree: TagView {
        override var tagBackgroundColor: UIColor{
            get{
                return .green
            }
            set{}
        }
        
        override var textColor: UIColor{
            get{
                return .black
            }
            
            set{
                
            }
        }
    }
}

