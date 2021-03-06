import Foundation


/// Web service data Loader
public class WebServiceDataLoader:DataLoader
{
    
    /// Events loaded flag
    public var eventsLoaded: Bool = false
    
    /// User loaded flag
    public var userLoaded: Bool = false
    
    /// User preferences
    private var prefs = UserDefaults()
    
    
    /// HTTPRequest request instance
    var httpRequest = HTTPRequest()
    
    /// Load data from web service
    public override func LoadData() {
        httpRequest.wsResultDelegate = self
        httpRequest.requestHosts()
        httpRequest.requestEvents()
    }
    
    /// Load User
    ///
    /// - Parameters:
    ///   - username: String
    ///   - password: String
    public override func LoadUser(username: String, password: String) {
        httpRequest.wsResultDelegate = self
        httpRequest.requestUser(username: username, password: password)
    }
    
    /// CreateFacebookEvent
    ///
    /// - Parameters:
    ///   - eventId: Int
    ///   - sessionId: String
    ///   - oAuthToken: String
    public override func CreateFacebookEvent(eventId: String, sessionId: String, oAuthToken: String) {
        httpRequest.wsResultDelegate = self
        httpRequest.createFacebookEvent(eventId: eventId, sessionId: sessionId, oAuthToken: oAuthToken)
    }
    
    
    /// Check user Auth status
    ///
    /// - Parameter sessionId: String
    public override func CheckUserAuth(sessionId: String) {
        httpRequest.wsResultDelegate = self
        httpRequest.requestAuth(sessionId: sessionId)
    }
    
    
    /// Show data loaded from web service
    public func showLoadedData()
    {
        if(self.eventsLoaded){
            self.bindData()
            self.dataLoaded()
        }
    }
    
    
    /// Bind new Events data and remove old data
    private func bindData()
    {
        DbController.sharedDBInstance.realm.beginWrite()
        try! DbController.sharedDBInstance.realm.commitWrite()
        
        var notThese = [Int] ()
        for event in events!
        {
            DbController.sharedDBInstance.realmAddEvent(o: event)
            notThese.append(event.id)
        }
        
        DbController.sharedDBInstance.realmDeleteEvents(notThese: notThese)
    }
    
    /// Bind new Hosts data and remove old data
    public func bindHosts(hosts: Array<Host>)
    {
        DbController.sharedDBInstance.realm.beginWrite()
        try! DbController.sharedDBInstance.realm.commitWrite()
        
        var notThese = [Int] ()
        for host in hosts
        {
            DbController.sharedDBInstance.realmAdd(o: host)
            notThese.append(host.id)
        }
        
        DbController.sharedDBInstance.realmDeleteHosts(notThese: notThese)
    }
    
    /// Bind new User data and remove old data
    public func bindUser(user: User)
    {
        DbController.sharedDBInstance.realmDeleteUser()
        
        DbController.sharedDBInstance.realmAdd(o: user)
    }
    
    /// Bind new Event data and remove old data
    public func bindEvent(event: Event)
    {
        DbController.sharedDBInstance.realm.beginWrite()
        //DbController.sharedDBInstance.realm.deleteAll()
        try! DbController.sharedDBInstance.realm.commitWrite()
        
        DbController.sharedDBInstance.realmAdd(o: event)
    }
    
    /// Load Location data from Google Geocoding API
    public func getLocation(address: String)
    {
        httpRequest.wsResultDelegate = self
        httpRequest.getLatLngFromAddress(address: address)
    }
}

extension WebServiceDataLoader: WebServiceResultDelegate{
    
    /// Get and parse Result to Delegate
    ///
    /// - Parameters:
    ///   - json: json
    ///   - type: String
    public func getResult(json: AnyObject, type: String) {
        switch type {
            case "events":
                self.events = JsonAdapter.getEvents(json: json)
                self.eventsLoaded = true
                self.showLoadedData()
                break
            case "user":
                self.user = JsonAdapter.getUser(json: json)
                self.userLoaded = true
                self.bindUser(user: user!)
                self.userLogged()
                break
            case "event":
                //let event = JsonAdapter.getEvent(json: json)
                //self.bindEvent(event: event)
                DBDataLoader().LoadData()
                break
            case "hosts":
                let hosts = JsonAdapter.getHosts(json: json)
                self.bindHosts(hosts: hosts)
                break
            case "auth":
                let user = JsonAdapter.getUser(json: json)
                if (user.id != 0) {
                    self.user = user
                } else {
                    self.user = User()
                }
                
                self.bindUser(user: user)
                self.userLoaded = true
                self.userLogged()
            break
            case "facebook":
                let status = JsonAdapter.getFacebookImportStatus(json: json)
                self.eventCreated(status: status)
            break
            case "location":
                let latLng = JsonAdapter.getLocation(json: json)
                self.locationFetched(latLng: latLng)
            break
            default:
                //not valid type
                break
        }
    }

}
