//
//  EventDetailController.swift
//  VzLife
//
//  Created by Ante Baric on 04/12/2016.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift
import Firebase

class EventDetailController: UIViewController, UITabBarDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var hostLabel: HostLabel!
    @IBOutlet weak var facebookLable: UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var buttonFavorite: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    
    var event: Event = Event()
    var eventInfo = [Any] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        event = try! Realm().object(ofType: Event.self, forPrimaryKey: event.id)!
        
        tabBar.delegate = self
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
        
        hostLabel.host = try! Realm().object(ofType: Host.self, forPrimaryKey: event.author)!
        hostLabel.text = "Organizator: " + event.host
        hostLabel.isUserInteractionEnabled = true
        let hostTap = UITapGestureRecognizer(target: self, action: #selector(self.goToEventHost(sender:)))
        hostLabel.addGestureRecognizer(hostTap)
        
        facebookLable.isUserInteractionEnabled = true
        let facebookTap = UITapGestureRecognizer(target: self, action: #selector(self.openFacebookPage(sender:)))
        facebookLable.addGestureRecognizer(facebookTap)
        
        locationLabel.text = "Lokacija događaja"
        locationLabel.isUserInteractionEnabled = true
        let locationTap = UITapGestureRecognizer(target: self, action: #selector(self.goToEventLocation(sender:)))
        locationLabel.addGestureRecognizer(locationTap)
        
        categoryLabel.text = "Kategorija: " + event.category
        categoryLabel.isUserInteractionEnabled = true
        let categoryTap = UITapGestureRecognizer(target: self, action: #selector(self.goToEventCategory(sender:)))
        categoryLabel.addGestureRecognizer(categoryTap)
        
        imageView.kf.setImage(with: URL(string: event.image))
        textView.text = event.text.replacingOccurrences(of: "<br />", with: "\n", options: .regularExpression, range: nil)
        
        //adjust label positions
        dateLabel.frame.origin.y = imageView.frame.origin.y + imageView.frame.height
        timeLabel.frame.origin.y = dateLabel.frame.origin.y + dateLabel.frame.height
        hostLabel.frame.origin.y = timeLabel.frame.origin.y + timeLabel.frame.height
        facebookLable.frame.origin.y = hostLabel.frame.origin.y + hostLabel.frame.height
        
        if(event.facebook=="") {
            facebookLable.isHidden = true
            categoryLabel.frame.origin.y = hostLabel.frame.origin.y + hostLabel.frame.height
            textView.frame = CGRect(x: textView.frame.origin.x, y: textView.frame.origin.y, width: textView.frame.width, height: textView.frame.height + facebookLable.frame.height)
        } else {
            facebookLable.text = "Facebook stranica"
            categoryLabel.frame.origin.y = facebookLable.frame.origin.y + facebookLable.frame.height
        }

        locationLabel.frame.origin.y = categoryLabel.frame.origin.y + categoryLabel.frame.height
        textView.frame.origin.y = locationLabel.frame.origin.y + locationLabel.frame.height
        
        if (event.favorite) {
            tabBar.selectedItem = tabBar.items![0] as UITabBarItem
        }
        
        //adjust text size
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame;
        
        //calc scroll height
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: textView.frame.height + imageView.frame.height + dateLabel.frame.height + timeLabel.frame.height + facebookLable.frame.height + locationLabel.frame.height + hostLabel.frame.height + categoryLabel.frame.height + 150)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let realm = try! Realm()
        do {
            try! realm.write() {
                let request = HTTPRequest()
    
                if (event.favorite) {
                    event.favorite = false
                    tabBar.selectedItem = nil
                    
                    request.unFavoriteEvent(token: FIRInstanceID.instanceID().token()!, eventId: event.id)
                } else {
                    event.favorite = true
                    
                    request.favoriteEvent(token: FIRInstanceID.instanceID().token()!, eventId: event.id)
                }
                
                realm.add(event, update: true)
            }
        }
    }
    
    func openFacebookPage(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(NSURL(string: event.facebook) as! URL)
    }
    
    func goToEventHost( sender: HostLabel){
        //passing Sender
        self.performSegue(withIdentifier: "Host", sender: hostLabel)
    }
    
    func goToEventLocation( sender: UILabel){
        //passing Sender
        self.performSegue(withIdentifier: "EventLocation", sender: sender)
    }
    
    func goToEventCategory( sender: UILabel){
        //passing Sender
        self.performSegue(withIdentifier: "EventCategory", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //We know that sender is a button
        if segue.identifier == "Host"{
            //casting sender to UIButton
            let sender = sender as! HostLabel
            let eventDetail = segue.destination as! HostController
            
            eventDetail.host = sender.host
            
        } else if(segue.identifier == "EventLocation") {
            //casting sender to UIButton
            let eventLocation = segue.destination as! EventLocationController
            
            eventLocation.event = self.event
            eventLocation.host = self.hostLabel.host
        } else if(segue.identifier == "EventCategory") {
            //casting sender to UIButton
            let eventCategory = segue.destination as! EventCategoryController
            
            eventCategory.category = event.category
        }
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
