import UIKit
import GoogleMaps

class EventLocationController: UIViewController {
    var event: Event = Event()
    var host: Host = Host()
    var mapView: GMSMapView
    let webService = WebServiceDataLoader()
    
    required init?(coder aDecoder: NSCoder) {
        let camera = GMSCameraPosition.camera(withLatitude: 46.3097734, longitude: 16.3468331, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = mapView
        
        webService.onLocationFetchedDelegate = self
        webService.getLocation(address: host.address)
    }
}

extension EventLocationController: OnLocationFetchedDelegate {
    public func onLocationFetched(latLng: Dictionary<String, Any>) {
        var location = Dictionary<String, Any>()
        
        if latLng.isEmpty {
            self.displayAlertMessage(userMessage: "Nismo pronašli organizatora na mapi, ali možete svakako svratiti u VaraždinEvents za više informacija.")
            
            location = ["lat": 46.309773399999997, "lng": 16.346833100000001, "address": "Ul. Julija Merlića 9, 42000, Varaždin, Croatia"]
        } else {
            location = latLng
        }
        
        // Creates a marker for event location
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location["lat"] as! CLLocationDegrees, longitude: location["lng"] as! CLLocationDegrees)
        
        if latLng.isEmpty {
            marker.title = "VaraždinEvents"
        } else {
            marker.title = host.name
        }
        
        marker.snippet = location["address"] as! String?
        self.navigationItem.title = location["address"] as! String?
        marker.map = mapView
    }

    func displayAlertMessage(userMessage: String){
        
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }
}

