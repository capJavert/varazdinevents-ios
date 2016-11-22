import Foundation

public protocol OnDataLoadedDelegate {
    func onDataLoaded(events : [Event])
}
public class DataLoader
{
    public var events:[Event]?
    public var onDataLoadedDelegate:OnDataLoadedDelegate?
    
    func LoadData() {}
    public init(){}
    public func dataLoaded() {
        if (events==nil) {
            //data not loaded
        }
        else {
            onDataLoadedDelegate?.onDataLoaded(events: events!)
        }
        
    }
}
