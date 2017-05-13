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
    
    /// Load data
    public override func LoadCities(){
        DbController.sharedDBInstance.dbResultDelegate = self
        showCitiesFromLocalDB()
    }
    
    /// Fetch Events
    private func showDataFromLocalDB()
    {
        DbController.sharedDBInstance.realmFetchEvents()
    }
    
    /// Fetch Events
    private func showCitiesFromLocalDB()
    {
        DbController.sharedDBInstance.realmFetchCities()
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
    
    public func getCities(result: [City]) {
        self.cities = result
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
