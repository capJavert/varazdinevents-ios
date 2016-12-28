//
//  EventDetailController.swift
//  VzLife
//
//  Created by Ante Baric on 04/12/2016.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit
import Kingfisher

class EventDetailController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var facebookLable: UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var event: Event = Event()
    var eventInfo = [Any] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.backgroundColor = UIColor.white
        
        //titleLabel.text = event.title
        self.navigationItem.title = event.title
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        let timeFormater = DateFormatter()
        timeFormater.dateFormat = "hh:mm"
        
        let date = Date(timeIntervalSince1970: TimeInterval(event.date))
        
        if(event.date_to==0) {
            dateLabel.text = "Datum: " + dateFormater.string(from: date)
            timeLabel.text = "Vrijeme: " + timeFormater.string(from: date)
        } else {
            let dateTo = Date(timeIntervalSince1970: TimeInterval(event.date_to))
            dateLabel.text = "Datum: " + dateFormater.string(from: date) + " - " + dateFormater.string(from: dateTo)
            timeLabel.text = "Vrijeme: " + timeFormater.string(from: date) + " - " + timeFormater.string(from: dateTo)
        }
        
        hostLabel.text = "Organizator: " + event.host
        if(event.facebook=="") {
            facebookLable.isHidden = true
        } else {
            facebookLable.text = "Facebook stranica"
        }
        
        facebookLable.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.openFacebookPage(sender:)))
        facebookLable.addGestureRecognizer(tap)

        
        categoryLabel.text = "Kategorija: " + event.category
        
        imageView.kf.setImage(with: URL(string: event.image))
        textView.text = event.text.replacingOccurrences(of: "<br />", with: "\n", options: .regularExpression, range: nil)
        
    }
    
    func openFacebookPage(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(NSURL(string: event.facebook) as! URL)
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
