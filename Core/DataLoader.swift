import Foundation


/// Data loaded delegate
public protocol OnDataLoadedDelegate {
    
    /// Data loaded protocol
    ///
    /// - Parameter events: [Event]
    func onDataLoaded(events : [Event])
}


/// User logged delegate
public protocol OnUserLoggedDelegate {
    
    /// User logged protocol
    ///
    /// - Parameter user: User
    func onUserLogged(user : User)
}


/// Event created delegate
public protocol OnEventCreatedDelegate {
    
    /// Event created protocol
    ///
    /// - Parameter status: Bool
    func onEventCreated(status: Bool)
}

/// Cities loaded delegate
public protocol OnCitiesLoadedDelegate {
    
    /// City loaded protocol
    ///
    /// - Parameter cities: [City]
    func onCitiesLoaded(cities : [City])
}

/// Location fetched delegate
public protocol OnLocationFetchedDelegate {
    
    /// Location fetched protocol
    ///
    /// - Parameter latLng: Dictionary<String, Any>
    func onLocationFetched(latLng: Dictionary<String, Any>)
}


/// Base data loader
public class DataLoader
{
    
    /// Events
    public var events:[Event]?
    
    /// Cities
    public var cities:[City]?
    
    /// User
    public var user: User?
    
    /// Data loaded delegate
    public var onDataLoadedDelegate:OnDataLoadedDelegate?
    
    /// Cities loaded delegate
    public var onCitiesLoadedDelegate:OnCitiesLoadedDelegate?

    /// User logged delegate
    public var onUserLoggedDelegate:OnUserLoggedDelegate?
    
    /// Event created delegate
    public var onEventCreatedDelegate:OnEventCreatedDelegate?
    
    /// Location fetched delegate
    public var onLocationFetchedDelegate:OnLocationFetchedDelegate?
    
    
    /// Load data
    func LoadData() {}
    
    /// Load cities
    func LoadCities() {}
    
    /// Load User
    ///
    /// - Parameters:
    ///   - username: String
    ///   - password: String
    func LoadUser(username: String, password: String) {}
    
    /// Check User Auth status
    ///
    /// - Parameter sessionId: String
    func CheckUserAuth(sessionId: String) {}
    
    /// Import facebook event from Graph API
    ///
    /// - Parameters:
    ///   - eventId: Int
    ///   - sessionId: String
    ///   - oAuthToken: String
    func CreateFacebookEvent(eventId: String, sessionId: String, oAuthToken: String) {}
    
    /// Init
    public init(){}
    
    
    /// Set data loaded flag
    public func dataLoaded() {
        if (events==nil) {
            //data not loaded
        }
        else {
            onDataLoadedDelegate?.onDataLoaded(events: events!)
        }
        
    }
   
    /// Set data loaded flag
    public func citiesLoaded() {
        if (cities==nil) {
            //data not loaded
        }
        else {
            onCitiesLoadedDelegate?.onCitiesLoaded(cities: cities!)
        }
        
    }
    
    /// Set event created flag
    ///
    /// - Parameter status: Bool
    public func eventCreated(status: Bool) {
        onEventCreatedDelegate?.onEventCreated(status: status)
    }
    
    
    /// Set user logged flag
    public func userLogged() {
        if (user==nil) {
            //data not loaded
        }
        else {
            onUserLoggedDelegate?.onUserLogged(user: user!)
        }
        
    }
    
    
    /// Set location fetched flag
    ///
    /// - Parameter latLng: LatLng
    public func locationFetched(latLng: Dictionary<String, Any>) {
        onLocationFetchedDelegate?.onLocationFetched(latLng: latLng)
    }
}
