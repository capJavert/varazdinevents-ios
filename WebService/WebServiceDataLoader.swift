import Foundation

public class WebServiceDataLoader:DataLoader
{
    public var eventsLoaded: Bool = false
    public var userLoaded: Bool = false
    private var prefs = UserDefaults()
    
    var httpRequest = HTTPRequest()
    
    
    public override func LoadData() {
        httpRequest.wsResultDelegate = self
        httpRequest.requestHosts()
        httpRequest.requestEvents()
    }
    
    public override func LoadUser(username: String, password: String) {
        httpRequest.wsResultDelegate = self
        httpRequest.requestUser(username: username, password: password)
    }
    
    public func showLoadedData()
    {
        if(self.eventsLoaded){
            self.bindData()
            self.dataLoaded()
        }
    }
    
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
    
    public func bindUser()
    {
        DbController.sharedDBInstance.realm.beginWrite()
        DbController.sharedDBInstance.realm.deleteAll()
        try! DbController.sharedDBInstance.realm.commitWrite()
        
        DbController.sharedDBInstance.realmAdd(o: user!)
    }
    
    public func bindEvent(event: Event)
    {
        DbController.sharedDBInstance.realm.beginWrite()
        DbController.sharedDBInstance.realm.deleteAll()
        try! DbController.sharedDBInstance.realm.commitWrite()
        
        DbController.sharedDBInstance.realmAdd(o: event)
    }
}

extension WebServiceDataLoader: WebServiceResultDelegate{
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
                self.bindUser()
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
            default:
                //not valid type
                break
        }
    }

}
