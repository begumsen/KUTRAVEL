
import Foundation
import OHMySQL

final class DatabaseManager {
    static let sharedInstance = DatabaseManager()
    
    init(){
        // Create a connection object
        let configuration = MySQLConfiguration(user: "root", password: "qwerty", serverName: "localhost", dbName: "app", port: 3306, socket: "/System/Volumes/Data/private/tmp/mysql.sock")
        let coordinator = MySQLStoreCoordinator(configuration: configuration)
        if coordinator.connect() {
           print("Connected successfully.")
        }
        let context = MySQLQueryContext()
        context.storeCoordinator = coordinator
        MySQLContainer.shared.mainQueryContext = context
    }
    
    func executeQuery (str: String) -> [[String: Any]] {
        let queryString = str
        
        let queryRequest = MySQLQueryRequest(query: queryString)
        do {
            let result = try MySQLContainer.shared.mainQueryContext?.executeQueryRequestAndFetchResult(queryRequest) ?? []
            return result
        } catch {
            print("Cannot execute the query.")
        }
        return []
    }
    
}
