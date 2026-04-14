
// This design pattern will be helpful for larger classes to copy instead of reinstantiate

import Foundation

typealias Codable = Encodable & Decodable

enum WallType: Codable {
    case foam
    case steel
    case plastic
    case concrete
}

enum LockerType: Codable {
    case physical
    case digital
}

enum CloneError: Error {
    case couldNotClone
}

protocol Clonable {
    func clone() throws -> Clonable
}

class Cargo: Codable {
    let height: Int
    let width: Int
    let length: Int
    var capacity: Int {
        return height * width * length
    }
    var lockerType: LockerType
    var wallType: WallType
    
    required init(height: Int = 12, width: Int = 10, length: Int = 18, lockerType: LockerType, wallType: WallType) {
        self.height = height
        self.width = width
        self.length = length
        self.lockerType = lockerType
        self.wallType = wallType
    }
}

extension Cargo: Clonable {
    // for nested classes but it will be slow1
    func clone() throws -> Clonable {
        do {
            let encodedData = try JSONEncoder().encode(self)
            
            let cargo = try JSONDecoder().decode(Cargo.self, from: encodedData)
            return cargo
        } catch (let _) {
            throw CloneError.couldNotClone
        }
    }
    
    // for small classes like non nested classes and faster clone
    func copy() -> Self {
        return type(of: self).init(
            height: self.height,
            width: self.width,
            length: self.length,
            lockerType: self.lockerType,
            wallType: self.wallType
        )
    }
}

// Usage
let cargo = Cargo(height: 12, width: 10, length: 18, lockerType: .physical, wallType: .steel)
let cargo1 = try cargo.clone()
let cargo2 = (cargo1 as? Cargo)?.copy()

if let cargo1 = cargo1 as? Cargo {
    cargo1.lockerType = .digital
    print(cargo1.lockerType) // .digital
}

print((cargo as? Cargo)?.lockerType)
print((cargo2 as? Cargo)?.lockerType)// .physical
