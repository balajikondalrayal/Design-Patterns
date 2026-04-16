//
//  Factory.swift
//  
//
//  Created by Balaji Kondalrayan on 14/04/26.

// Create a factory to create different types of trasportation based on the requirements

enum SpeedUnit {
    case kmph
    case knotsph
}

protocol Measurable {
    var maxSpeed: Int { get }
    var unit: SpeedUnit { get }
}

protocol Vehicle {
    var capacity: Int { get }
    func deliver()
}

class Ship: Vehicle, Measurable {
    let maxSpeed: Int = 40
    let unit: SpeedUnit = .knotsph
    var capacity: Int
    
    init(capacity: Int) {
        self.capacity = capacity
    }

    func deliver() {
        print("Delivering by ship with capacity \(capacity) at max speed of \(maxSpeed)\(unit)")
    }
}

class Truck: Vehicle, Measurable {
    let maxSpeed: Int = 80
    let unit: SpeedUnit = .kmph
    var capacity: Int

    init(capacity: Int) {
        self.capacity = capacity
    }

    func deliver() {
        print("Delivering by truck with capacity \(capacity) at max speed of \(maxSpeed)\(unit)")
    }
}

protocol Logistics {
    func createVehicle(capacity: Int) -> Vehicle
}

class SeaLogistics: Logistics {
    func createVehicle(capacity: Int) -> Vehicle {
        return Ship(capacity: capacity)
    }
}

class RoadLogistics: Logistics {
    func createVehicle(capacity: Int) -> Vehicle {
        return Truck(capacity: capacity)
    }
}

// Usage

let seaLogistics = SeaLogistics()
let ship = seaLogistics.createVehicle(capacity: 100)
ship.deliver() // Delivering by ship with capacity 100

let roadLogistics = RoadLogistics()
let truck = roadLogistics.createVehicle(capacity: 200)
truck.deliver() // Delivering by truck with capacity 200