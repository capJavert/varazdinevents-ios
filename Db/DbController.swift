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
        
        var items = self.realm.objects(Event.self)
        
        if (filterString != "") {
            items = self.realm.objects(Event.self).filter(filterString)
        }
        
        self.realm.beginWrite()
        self.realm.delete(items)
        try! self.realm.commitWrite()
    }
    
    public func realmDeleteHosts(notThese: Array<Int>) {
        var filterString = ""
        
        for id in notThese {
            if(filterString != "") {
                filterString += " AND "
            }
            filterString += ("id != "+String(id))
        }
        
        var items = self.realm.objects(Host.self)
        
        if (filterString != "") {
            items = self.realm.objects(Host.self).filter(filterString)
        }
        
        self.realm.beginWrite()
        self.realm.delete(items)
        try! self.realm.commitWrite()
    }
    
    public func realmDeleteUser() {
        let items = self.realm.objects(User.self)
        
        self.realm.beginWrite()
        self.realm.delete(items)
        try! self.realm.commitWrite()
    }
    
    public func realmAddEvent(o: Event)
    {
        let event = try! Realm().object(ofType: Event.self, forPrimaryKey: o.id)
        
        if((event) != nil) {
            if (event?.favorite)! {
                o.favorite = true
            }
        }
        
        if(!o.isInvalidated) {
            try! self.realm.write
            {
             self.realm.add(o, update: true)
            }
        } else {
            NSLog("invalidated")
        }
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


