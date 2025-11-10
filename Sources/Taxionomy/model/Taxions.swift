//
//  Taxions.swift
//  Taxion
//
//  Created by Herve Crespel on 31/10/2025.
//

struct Taxions : Codable {
    
    var items:[Taxion] = []
    
    init() {}
    
    init(_ first:Taxion) {
        items = [first]
    }
    
    init(_ parent:Taxion?) {
        if let taxion = parent {
            items = [taxion.child(1)]
        }
    }
    
    mutating func maj(_ taxion: Taxion) {
        var new : [Taxion] = []
        for item in items {
            if item.type == taxion.type {
                new.append(taxion)
            } else {
                new.append(item)
            }
        }
        items = new
    }
    
    mutating func delete(_ taxion:Taxion) {
        var new : [Taxion] = []
        for item in items {
            if item.type != taxion.type {
                new.append(item)
            }
        }
        items = new
    }
    
    var nextid: Int {
        let dim = items[0].dim - 1
        var max = 0
        for taxion in items {
            let id = taxion.type[dim]
            if id > max { max = id }
        }
        return max + 1
    }
    
    subscript (_ tidid:String) -> Taxion {
        var found = Taxion()
        for taxion in items {
            if taxion.id == tidid {
                found = taxion
            }
        }
        return found
    }
    
    func children(_ parent:Taxion) -> [Taxion] {
        var selection:[Taxion] = []
        if items.count > 0 {
            if parent.dim == items[0].dim - 1 {
                selection = items.filter{item in item.parent.id == parent.id}
            }
        }
        return selection
    }
}
