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
        DbController.sharedDBInstance.realmFetchStores()
    }
}

extension DBDataLoader:DBResultDelegate {
    public func getStores(result: [Event]) {
        self.events = result
        //self.dataLoaded()
    }
}
