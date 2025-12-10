//
//  File.swift
//  
//
//  Created by Herve Crespel on 11/12/2023.
//

import Foundation

public struct Mot : Codable {
    public static var inconnu = Mot("inconnu", "inconnus", .m)
    var genre : Genre?
    var singulier:String
    var pluriel:String

    public init(_ s:String,_ p:String?, _ g:Genre = .m) {
        singulier = s
        pluriel = p ?? ""
        genre = g
    }
    
    public var selector : String { singulier }
    public var tablename: String { pluriel }
    
    public var indéterminé: String {
        (genre ?? .m).indéterminé + " " + singulier
    }
    public var indéterminés: String {
        "des " + pluriel
    }
    public var déterminé: String {
        (genre ?? .m).déterminé + " " + singulier
    }
    public var déterminés: String {
        "les " + pluriel
    }
    public var démonstratifs: String {
        (genre == .f ? "cettes " : "ces ") + pluriel
    }
    
    public func quantifié(_ nombre: Int? = nil) -> String {
        if let q:Int = nombre {
            if q == 0 {
                "aucun " + singulier
            } else {
                if q == 1 {
                    singulier
                } else {
                    String(q) + " " + pluriel
                }
            }
        } else {
            pluriel
        }
    }
    
    public subscript(_ nb:Int = 1) -> String {
        switch nb {
        case -1, 0, 1:  return String(nb) + " " + singulier
        default:        return String(nb) + " " + pluriel
        }
    }
}
