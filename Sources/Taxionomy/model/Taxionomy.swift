//
//  Taxionomy.swift
//  Taxion
//
//  Created by Herve Crespel on 30/10/2025.
//
import Foundation


public struct Taxionomy: Codable {
    public static let besoins = Taxionomy(taxionomie2)
    public static func besoin(_ tid:TID) -> Taxion {
         besoins.find(tid)
    }
    
    var levels: [Taxions]
    public var dim : Int { levels.count }
    
    public init() {
        levels = []
    }
    
    public init(_ json:String) {
        let jsonData = json.data(using: .utf8)!
        let set = try! JSONDecoder().decode(Flataxon.self, from: jsonData)
        let itemset = set.items
        var dimax = 1
        for taxion in itemset {
            let dimitem = taxion.dim
            if  dimitem > dimax { dimax = dimitem }
        }
        levels = []
        for _ in 1...dimax {
            levels.append(Taxions())
        }
        for taxion in itemset {
            levels[taxion.dim-1].items.append(taxion)
        }
    }
    
    public func find(_ tid:TID) -> Taxion {
        let level = levels[tid.tab.count - 1]
        return level[tid.id]
    }
    public func find(_ tidid:String) -> Taxion {
        if dim > 0 {
            var dim = 0
            for character in tidid {
                if !character.isNumber { dim += 1 }
            }
            let level = levels[dim]
            return level[tidid]
        } else {
            return Taxion()
        }
    }
    
    var zero:   [Taxion] { levels[0].items }
    
    mutating func maj(_ taxion: Taxion) {
        levels[taxion.dim-1].maj(taxion)
    }
    
    mutating func delete(_ taxion: Taxion) {
        levels[taxion.dim-1].delete(taxion)
    }
    // crée un enfant vierge et l'ajoute au level
    mutating func add(_ parent:Taxion) -> Taxion {
        if parent.dim == dim {
            levels.append(Taxions())
        }

        let level = levels[parent.dim]
        let child_id = level.nextid
        if dim == 1 {
            
        }
        let child = parent.child(child_id)
        levels[parent.dim].items.append(child)
        return child
    }
    
    func children(_ parent:Taxion) -> [Taxion] {
        var selection: [Taxion] = []
        let dim = parent.dim
        if levels.count > dim {
            selection = levels[dim].children(parent)
        }
        return selection
    }
}


public struct Flataxon: Codable {
    var items:[Taxion]
}
