import Foundation
import Realm
import RealmSwift


/// Local data loader
public class DBDataLoader:DataLoader {
    
    
    /// Load data
    public override func LoadData(){
        DbController.sharedDBInstance.dbResultDelegate = self
        showDataFromLocalDB()
    }
    
    
    /// Fetch Events
    private func showDataFromLocalDB()
    {
        DbController.sharedDBInstance.realmFetchEvents()
    }
}

extension DBDataLoader:DBResultDelegate {
    
    /// Get Events
    ///
    /// - Parameter result: Events
    public func getEvents(result: [Event]) {
        self.events = result
        self.dataLoaded()
    }
    
    
    /// Get User
    ///
    /// - Parameter result: User
    public func getUser(result: User) {
        self.user = result
        self.userLogged()
    }
}
