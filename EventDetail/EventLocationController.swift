import UIKit
import GoogleMaps

class EventLocationController: UIViewController {
    var event: Event = Event()
    var host: Host = Host()
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 46.3097734, longitude: 16.3468331, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 46.3097734, longitude: 16.3468331)
        marker.title = "VaraždinEvents"
        marker.snippet = "Julija Merlića 9, Varaždin"
        marker.map = mapView
    }
}
