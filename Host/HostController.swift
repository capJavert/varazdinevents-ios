import UIKit
import RealmSwift
import Kingfisher
import Realm


/// Host view controller
class HostController: UIViewController{
    
    var user = User()
    var host: Host = Host()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var workHoursLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var moreInfoButton: HostEventButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreInfoButton.host = host
        moreInfoButton.addTarget(self, action: #selector(goToHostEvent(sender:)), for: .touchUpInside)
        
        self.navigationItem.title = host.name
        
        addressLabel = setLabel(label: addressLabel, value: host.address)
        phoneLabel = setLabel(label: phoneLabel, value: host.phone)
        workHoursLabel = setLabel(label: workHoursLabel, value: host.work_hours)
        
        facebookLabel = setLabel(label: facebookLabel, value: "Facebook stranica")
        facebookLabel.isUserInteractionEnabled = true
        let facebookTap = UITapGestureRecognizer(target: self, action: #selector(self.openFacebookPage(sender:)))
        facebookLabel.addGestureRecognizer(facebookTap)
        
        websiteLabel = setLabel(label: websiteLabel, value: host.website)
        websiteLabel.isUserInteractionEnabled = true
        let websiteTap = UITapGestureRecognizer(target: self, action: #selector(self.openWebPage(sender:)))
        websiteLabel.addGestureRecognizer(websiteTap)

        textView.text = host.about.replacingOccurrences(of: "<br />", with: "\n", options: .regularExpression, range: nil).replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: " ")
        imageView.kf.setImage(with: URL(string: host.image))
        
        //adjust label positions
        addressLabel.frame.origin.y = imageView.frame.origin.y + imageView.frame.height
        phoneLabel.frame.origin.y = addressLabel.frame.origin.y + addressLabel.frame.height
        workHoursLabel.frame.origin.y = phoneLabel.frame.origin.y + phoneLabel.frame.height
        facebookLabel.frame.origin.y = workHoursLabel.frame.origin.y + workHoursLabel.frame.height
        websiteLabel.frame.origin.y = facebookLabel.frame.origin.y + facebookLabel.frame.height
        moreInfoButton.frame.origin.y = websiteLabel.frame.origin.y + websiteLabel.frame.height + 10
        textView.frame.origin.y = moreInfoButton.frame.origin.y + websiteLabel.frame.height + 10
        
        //adjust text size
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame;
        
        //calc scroll height
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: textView.frame.height + imageView.frame.height + websiteLabel.frame.height + phoneLabel.frame.height + facebookLabel.frame.height + addressLabel.frame.height + workHoursLabel.frame.height + moreInfoButton.frame.height + 20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func goToHostEvent( sender: HostEventButton){
        //passing Sender
        self.performSegue(withIdentifier: "HostEvent", sender: moreInfoButton)
    }
    
    @objc func openFacebookPage(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(NSURL(string: host.facebook)! as URL)
    }
    
    @objc func openWebPage(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(NSURL(string: host.website)! as URL)
    }
    
    
    func setLabel(label: UILabel, value: Any) -> UILabel {
        if (value as! String != "") {
            label.text = value as? String
        } else {
            label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width, height: 0)
            label.isHidden = true
        }
        
        return label
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //We know that sender is a button
        if segue.identifier == "HostEvent"{
            //casting sender to UIButton
            let sender = sender as! HostEventButton
            let hostEvent = segue.destination as! HostEventController
            
            hostEvent.host = sender.host
            
        }
    }
}



