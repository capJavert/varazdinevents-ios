import Foundation

public protocol OnDataLoadedDelegate {
    func onDataLoaded(events : [Event])
}

public protocol OnUserLoggedDelegate {
    func onUserLogged(user : User)
}

public class DataLoader
{
    public var events:[Event]?
    public var user: User?
    public var onDataLoadedDelegate:OnDataLoadedDelegate?
    public var onUserLoggedDelegate:OnUserLoggedDelegate?
    
    func LoadData() {}
    func LoadUser(username: String, password: String) {}
    
    public init(){}
    public func dataLoaded() {
        if (events==nil) {
            //data not loaded
        }
        else {
            onDataLoadedDelegate?.onDataLoaded(events: events!)
        }
        
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
