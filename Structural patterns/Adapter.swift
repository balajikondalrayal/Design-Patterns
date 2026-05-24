//
//  Adapter.swift
//  
//
//  Created by Balaji Kondalrayan on 24/05/26.
//

/* Adapter pattern is used to convert the interface of a class into another interface that clients expect. It allows classes to work together that couldn't otherwise because of incompatible interfaces. */

/* Creating the DroneAdapter which adapts the legacy Drone interface */

class LegacyDrone {
    func launch() {
        print("Launching the legacy drone")
    }
}

// As we are usiing the vehicle prorotcol in this fleet tracker application, we need to adapt the legacy drone to fit into the vehicle protocol
protocol Vehicle {
    var capacity: Int { get }
    func deliver()
}

class DroneAdapter: Vehicle {
    private let legacyDrone: LegacyDrone

    var capacity: Int {
        return 5
    }

    init(legacyDrone: LegacyDrone) {
        self.legacyDrone = legacyDrone
    }

    func deliver() {
        print("Delivering the drone with capacity \(capacity) kg")
        legacyDrone.launch()
    }
}

let legacyDrone = LegacyDrone()
let droneAdapter = DroneAdapter(legacyDrone: legacyDrone)
droneAdapter.deliver()
