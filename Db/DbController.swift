import Foundation
import RealmSwift

public protocol DBResultDelegate{
    func getEvents(result:[Event])
}
public class DbController
{
    
    public static var sharedDBInstance = DbController()
    
    public var dbResultDelegate:DBResultDelegate?
    public let realm = try! Realm()
    
    public func realmAdd(o: Object)
    {
        
        if(!o.isInvalidated) {
            try! self.realm.write
                {
                    self.realm.add(o)
            }
        } else {
            NSLog("invalidated")
        }
    }
    
    public func realmFetchEvents()
    {
        let data = self.realm.objects(Event.self)
        dbResultDelegate?.getEvents(result: data.reversed())
    }
}


