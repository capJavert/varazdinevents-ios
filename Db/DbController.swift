import Foundation
import RealmSwift

public protocol DBResultDelegate{
    func getEvents(result:[Event])
    func getUser(result:User)
}

public class DbController
{
    
    public static var sharedDBInstance = DbController()
    
    public var dbResultDelegate:DBResultDelegate?
    public let realm = try! Realm()
    
    public func realmDeleteEvents(notThese: Array<Int>) {
        var filterString = ""
        for id in notThese {
            if(filterString != "") {
                filterString += " AND "
            }
            filterString += ("id != "+String(id))
        }
        
        let items = self.realm.objects(Event.self).filter(filterString)
        
        self.realm.beginWrite()
        self.realm.delete(items)
        try! self.realm.commitWrite()
    }
    
    public func realmAdd(o: Object)
    {
        if(!o.isInvalidated) {
            try! self.realm.write
            {
             self.realm.add(o, update: true)
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
    
    public func realmFetchUser(id: Int)
    {
        let data = self.realm.object(ofType: User.self, forPrimaryKey: id)
        dbResultDelegate?.getUser(result: data!)
    }
}


