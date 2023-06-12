
import Foundation

struct Ride: Hashable {
    let rideId: String
    let fromLocation: String
    let toLocation: String
    let date: Date
    let seatAvailable: Int
    let fee: Int
    let mail: String
    var hitched: Bool
}
