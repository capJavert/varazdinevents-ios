import Foundation

public protocol OnDataLoadedDelegate {
    func onDataLoaded(events : [Event])
}

public protocol OnUserLoggedDelegate {
    func onUserLogged(user : User)
}

public protocol OnEventCreatedDelegate {
    func onEventCreated(status: Bool)
}

public class DataLoader
{
    public var events:[Event]?
    public var user: User?
    public var onDataLoadedDelegate:OnDataLoadedDelegate?
    public var onUserLoggedDelegate:OnUserLoggedDelegate?
    public var onEventCreatedDelegate:OnEventCreatedDelegate?
    
    func LoadData() {}
    func LoadUser(username: String, password: String) {}
    func CheckUserAuth(sessionId: String) {}
    func CreateFacebookEvent(eventId: String, sessionId: String, oAuthToken: String) {}
    
    public init(){}
    public func dataLoaded() {
        if (events==nil) {
            //data not loaded
        }
        else {
            onDataLoadedDelegate?.onDataLoaded(events: events!)
        }
        
    }
    
    public func eventCreated(status: Bool) {
        onEventCreatedDelegate?.onEventCreated(status: status)
    }
    
    public func userLogged() {
        if (user==nil) {
            //data not loaded
        }
        else {
            onUserLoggedDelegate?.onUserLogged(user: user!)
        }
        
    }
}
