import Foundation
import RealmSwift

public protocol DBResultDelegate{
    func getStores(result:[Event])
}
public class DbController
{
    
    public static var sharedDBInstance = DbController()
    
    public var dbResultDelegate:DBResultDelegate?
    public let realm = try! Realm()
    
    public func realmAdd(o: Object)
    {
        try! self.realm.write
        {
                self.realm.add(o)
        }
    }
    
    public func realmFetchStores()
    {
        let data = self.realm.objects(Event.self)
        dbResultDelegate?.getStores(result: data.reversed())
    }
}


