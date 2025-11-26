//
//  Idnom.swift
//  Taxionomy
//
//  Created by Herve Crespel on 26/11/2025.
//

public struct Idnom: Codable {
    var id:     String   // identifiant d'un taxion dans une taxionomie
    var nom:    String
    
    public init(_ taxion:Taxion) {
        id = taxion.id
        nom = taxion.short
    }
    
    public func noms(_ taxionomy:Taxionomy) -> [String] {
        taxionomy.find(id).noms
    }
}
