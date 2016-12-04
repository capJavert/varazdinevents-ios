//
//  EventDetailController.swift
//  VzLife
//
//  Created by Ante Baric on 04/12/2016.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit
import Kingfisher

class EventDetailController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var event: Event = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView.kf.setImage(with: URL(string: event.image))
        textView.text = event.text
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}


class InfosTableViewCell: UITableViewCell{
    
    
}
