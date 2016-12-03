import Foundation

public class WebServiceDataLoader:DataLoader
{
    public var eventsLoaded: Bool = false
    private var prefs = UserDefaults()
    
    var httpRequest = HTTPRequest()
    
    
    public override func LoadData() {
        httpRequest.wsResultDelegate = self
        httpRequest.httprequest(url: "http://varazdinevents.cf/api/events", method: .get, params: [:])
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
        DbController.sharedDBInstance.realm.deleteAll()
        try! DbController.sharedDBInstance.realm.commitWrite()
        
        for event in events!
        {
            DbController.sharedDBInstance.realmAdd(o: event)
        }
    }
}

extension WebServiceDataLoader: WebServiceResultDelegate{
    public func getResult(json: AnyObject) {
        self.eventsLoaded = true
        self.events = JsonAdapter.getEvents(json: json)
        self.showLoadedData()
    }
}
