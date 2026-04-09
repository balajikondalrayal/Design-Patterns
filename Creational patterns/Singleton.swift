//
//  Singleton.swift
//  
//
//  Created by Balaji Kondalrayan on 09/04/26.
//

/* Creating a global configuration manager to handle system wide seetings like tax rates and API keys */

// Verison 1 -> Same class holds all the data

// Use this version for static data which we have already in our app
class GlobalConfiguration {
    static let shared = GlobalConfiguration()

    let apiKeys: [String]
    let taxRate: Double

    private init() {
        // you can load the below values from environment, plist, etc.
        self.apiKeys = ["API_KEY", "SESSION_KEY"]
        self.taxRate = 12
    }
}

// Usage
struct ViewModel {
    let price: Double
    var priceWithTax: Double {
        return price + (price * (GlobalConfiguration.shared.taxRate / 100))
    }
}


// Version 2 - GlobalConfiguration has separate class for configuration whihc holds all the data

// Use this version if the data is coming from APIs
class GlobalConfig {
    private(set) static var sharedConfig: Configuration?

    static func setupConfiguration(apiKeys: [String], taxRate: Double) {
        if(sharedConfig == nil) {
            sharedConfig = Configuration(apiKeys: apiKeys, taxRate: taxRate)
        }
    }
}

class Configuration {
    let apiKeys: [String]
    let taxRate: Double

    init(apiKeys: [String], taxRate: Double) {
        self.apiKeys = apiKeys
        self.taxRate = taxRate
    }
}