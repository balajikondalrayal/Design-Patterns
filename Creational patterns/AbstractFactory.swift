//
//  AbstractFactory.swift
//  
//
//  Created by Balaji Kondalrayan on 17/04/26.

// Create a Regional hub factory
// US hub produces US-style trucks and EU hub produces EU-style trucks

enum SpeedUnit {
    case kmph
    case mph
}

enum EnginePlacement {
    case front
    case underBody
}

protocol Vehicle {
    var capacity: Int { get }
    var speedUnit: SpeedUnit { get }
    var enginePlacement: EnginePlacement { get }
    func deliver()
}

protocol Driver {
    associatedtype VehicleType: Vehicle

    var vehicle: VehicleType { get }
    var name: String { get }
    var licenseType: String { get }
    func drive()
    func speak()
}

class USATruckDriver: Driver {
    var name: String
    var licenseType: String = "Class A"
    var vehicle: USATruck

    init(name: String, vehicle: USATruck) {
        self.name = name
        self.vehicle = vehicle
    }

    func drive() {
        print("\(name) is driving a USA truck with capacity \(vehicle.capacity) tons")
    }

    func speak() {
        print("\(name) says: 'Howdy!' Ready to hit the road in the USA.")
    }
}

class EUTruckDriver: Driver {
    var name: String
    var licenseType: String = "Category C"
    var vehicle: EUTruck

    init(name: String, vehicle: EUTruck) {
        self.name = name
        self.vehicle = vehicle
    }

    func drive() {
        print("\(name) is driving a EU truck with capacity \(vehicle.capacity) tons")
    }

    func speak() {
        print("\(name) says: 'Hello!' Happy to drive in Europe.")
    }
}

class USATruck: Vehicle {
    var capacity: Int
    var speedUnit: SpeedUnit = .mph
    var enginePlacement: EnginePlacement = .front


    init(capacity: Int) {
        self.capacity = capacity
    }

    func deliver() {
        print("Delivering by USA truck with capacity \(capacity) tons")
    }
}

class EUTruck: Vehicle {
    var capacity: Int
    var speedUnit: SpeedUnit = .kmph
    var enginePlacement: EnginePlacement = .underBody

    init(capacity: Int) {
        self.capacity = capacity
    }

    func deliver() {
        print("Delivering by EU truck with capacity \(capacity) tons")
    }
}

protocol RegionalFactory {
    func createTrip(driverName: String, truckCapacity: Int) -> (any Driver, Vehicle)
}

class USFactory: RegionalFactory {
    func createTrip(driverName: String, truckCapacity: Int) -> (any Driver, Vehicle) {
        let truck = USATruck(capacity: truckCapacity)
        let driver = USATruckDriver(name: driverName, vehicle: truck)
        return (driver, truck)
    }
}

class EUFactory: RegionalFactory {
    func createTrip(driverName: String, truckCapacity: Int) -> (any Driver, Vehicle) {
        let truck = EUTruck(capacity: truckCapacity)
        let driver = EUTruckDriver(name: driverName, vehicle: truck)
        return (driver, truck)
    }
}


// Usage

// Creating the US Truck with capacity of 1000 and driver John
let (usDriver, usTruck) = USFactory().createTrip(driverName: "John", truckCapacity: 22)
usDriver.speak()
usDriver.drive()
usTruck.deliver()


// Creating the EU Truck with capacity of 1000 and driver Marie
let (euDriver, euTruck) = EUFactory().createTrip(driverName: "Marie", truckCapacity: 22)
euDriver.speak()
euDriver.drive()
euTruck.deliver()


