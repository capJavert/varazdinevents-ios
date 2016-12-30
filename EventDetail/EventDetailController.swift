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

class EventDetailController: UIViewController, UITabBarDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var hostLabel: HostLabel!
    @IBOutlet weak var facebookLable: UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
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
        
        if(event.facebook=="") {
            facebookLable.isHidden = true
        } else {
            facebookLable.text = "Facebook stranica"
        }
        facebookLable.isUserInteractionEnabled = true
        let facebookTap = UITapGestureRecognizer(target: self, action: #selector(self.openFacebookPage(sender:)))
        facebookLable.addGestureRecognizer(facebookTap)
        
        categoryLabel.text = "Kategorija: " + event.category
        
        imageView.kf.setImage(with: URL(string: event.image))
        textView.text = event.text.replacingOccurrences(of: "<br />", with: "\n", options: .regularExpression, range: nil)
        
        if (event.favorite) {
            tabBar.selectedItem = tabBar.items![0] as UITabBarItem
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let realm = try! Realm()
        do {
            try! realm.write() {
                if (event.favorite) {
                    event.favorite = false
                    tabBar.selectedItem = nil
                } else {
                    event.favorite = true
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //We know that sender is a button
        if segue.identifier == "Host"{
            //casting sender to UIButton
            let sender = sender as! HostLabel
            let eventDetail = segue.destination as! HostController
            
            eventDetail.host = sender.host
            
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
