import Foundation
import Pods_VarazdinEvents_Db

public protocol DataLoader
{
    var stores:[Event]{get set}
    func LoadData()
}
