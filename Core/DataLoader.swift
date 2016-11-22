import Foundation

public protocol DataLoader
{
    var stores:[Event]{get set}
    func LoadData()
}
