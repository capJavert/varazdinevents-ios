//
//  aboutController.swift
//  VzLife
//
//  Created by FOI on 25/01/17.
//  Copyright © 2017 varazdinevents. All rights reserved.
//

import UIKit

class AboutController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "O nama"
        
        //adjust text size
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame;
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: imageView.frame.size.height + textView.frame.size.height + 150)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
