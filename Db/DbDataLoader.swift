import Foundation
import Realm
import RealmSwift

public class DBDataLoader:DataLoader {
    
    public override func LoadData(){
        DbController.sharedDBInstance.dbResultDelegate = self
        showDataFromLocalDB()
    }
    
    private func showDataFromLocalDB()
    {
        DbController.sharedDBInstance.realmFetchEvents()
    }
}

extension DBDataLoader:DBResultDelegate {
    public func getEvents(result: [Event]) {
        self.events = result
        self.dataLoaded()
    }
}
