import UIKit
import RealmSwift
import Kingfisher
import Realm

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

        textView.text = host.about.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&nbsp;", with: " ")
        imageView.kf.setImage(with: URL(string: host.image))
    }
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToHostEvent( sender: HostEventButton){
        //passing Sender
        self.performSegue(withIdentifier: "HostEvent", sender: moreInfoButton)
    }
    
    func openFacebookPage(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(NSURL(string: host.facebook) as! URL)
    }
    
    func openWebPage(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(NSURL(string: host.website) as! URL)
    }
    
    
    func setLabel(label: UILabel, value: Any) -> UILabel {
        if (host.address != "") {
            label.text = value as? String
        } else {
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



