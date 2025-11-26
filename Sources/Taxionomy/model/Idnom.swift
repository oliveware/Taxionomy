//
//  Idnom.swift
//  Taxionomy
//
//  Created by Herve Crespel on 26/11/2025.
//

// structure de stockage simplifié d'un taxion  
public struct Idnom: Codable {
    var id:     String   // identifiant d'un taxion dans une taxionomie
    public var nom:    String
    
    public init(_ taxion:Taxion) {
        id = taxion.id
        nom = taxion.short
    }
    
    public init() {
        id = ""
        nom = ""
    }
    
    public var isNaN : Bool { id == "" && nom == "" }
    
    public func noms(_ taxionomy:Taxionomy) -> [String] {
        taxionomy.find(id).noms
    }
}
