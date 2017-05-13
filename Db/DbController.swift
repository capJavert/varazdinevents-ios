import Foundation
import RealmSwift


/// Local Db result Delegate
public protocol DBResultDelegate{
    
    /// Get Events
    ///
    /// - Parameter result: [Event]
    func getEvents(result:[Event])
    
    /// Get Cities
    ///
    /// - Parameter result: [City]
    func getCities(result:[City])
    
    /// Get User
    ///
    /// - Parameter result: User
    func getUser(result:User)
}


/// Local Database controller
public class DbController
{
    
    /// Shared local Db instance
    public static var sharedDBInstance = DbController()
    
    
    /// Db result delegate
    public var dbResultDelegate:DBResultDelegate?
    
    /// Realm instance
    public let realm = try! Realm()
    
    
    /// Delete Events
    ///
    /// - Parameter notThese: Array<Int>
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
    
    
    /// Delete Hosts
    ///
    /// - Parameter notThese: Array<Int>
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
    
    /// Delete Hosts
    ///
    /// - Parameter notThese: Array<Int>
    public func realmDeleteCities(notThese: Array<Int>) {
        var filterString = ""
        
        for id in notThese {
            if(filterString != "") {
                filterString += " AND "
            }
            filterString += ("id != "+String(id))
        }
        
        var items = self.realm.objects(City.self)
        
        if (filterString != "") {
            items = self.realm.objects(City.self).filter(filterString)
        }
        
        self.realm.beginWrite()
        self.realm.delete(items)
        try! self.realm.commitWrite()
    }
    
    /// Delete User
    public func realmDeleteUser() {
        let items = self.realm.objects(User.self)
        
        self.realm.beginWrite()
        self.realm.delete(items)
        try! self.realm.commitWrite()
    }
    
    
    /// Add Event
    ///
    /// - Parameter o: Event
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
    
    
    /// Add Realm object
    ///
    /// - Parameter o: Object
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
    
    
    /// Get Events
    public func realmFetchEvents()
    {
        let data = self.realm.objects(Event.self).sorted(byProperty: "date")
        dbResultDelegate?.getEvents(result: data.reversed())
    }
    
    /// Get Cities
    public func realmFetchCities()
    {
        let data = self.realm.objects(City.self).sorted(byProperty: "date")
        dbResultDelegate?.getCities(result: data.reversed())
    }
    
    /// Get User
    ///
    /// - Parameter id: Int
    public func realmFetchUser(id: Int)
    {
        let data = self.realm.object(ofType: User.self, forPrimaryKey: id)
        dbResultDelegate?.getUser(result: data!)
    }
}


