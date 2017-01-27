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

    override func viewDidLoad() {
        super.viewDidLoad()
        
          scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: textView.frame.size.height + 150)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
