import Foundation
import Vapor
import SwiftJWT

// Configuration from environment variables
guard let nightscoutURL = URL(string: ProcessInfo.processInfo.environment["NIGHTSCOUT_URL"] ?? ""),
      let nightscoutToken = URL(string: ProcessInfo.processInfo.environment["NIGHTSCOUT_TOKEN"] ?? "")
       else {
    fatalError("Environment variables not set")
}

let nsURL = nightscoutURL + "/api/v1/entries/sgv.json?count=10&token=" + nightscoutToken
// Function to get the latest glucose level from Nightscout
func getLatestGlucoseLevel(completion: @escaping (Int?) -> Void) {
    let client = HTTPClient(eventLoopGroupProvider: .createNew)
    defer { try? client.syncShutdown() }
    client.get(url: nsURL).whenComplete { result in
        switch result {
        case .failure(let error):
            print("Error fetching data: \(error)")
            completion(nil)
        case .success(let response):
            if let body = response.body {
                let data = body.getData(at: 0, length: body.readableBytes)!
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let sgv = json.first?["sgv"] as? Int {
                    completion(sgv)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}


// Main function to check conditions
func main() {
    getLatestGlucoseLevel { glucoseLevel in
        guard let glucoseLevel = glucoseLevel else { return }
        if glucoseLevel > 180 {  // Example condition for high glucose level
            print("high glucose")
        } else if glucoseLevel < 70 {  // Example condition for low glucose level
            print("low glucose")
        } else {
            print("Normal glucose: \(glucoseLevel)")
        }
    }
}

// Run the main function
main()
