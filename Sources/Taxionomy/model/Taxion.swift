// The Swift Programming Language
// https://docs.swift.org/swift-book

//
//  Taxion.swift
//  Taxonomy
//
//  Created by Herve Crespel on 30/10/2025.
//
import Foundation

public struct Taxion : Codable, Identifiable {
    
    public static func == (_ a:Taxion, _ b:Taxion) -> Bool {
        a.id == b.id
    }
    static func < (_ a:Taxion, _ b:Taxion) -> Bool {
        a.nom < b.nom
    }
    
    public var id:String {
        TID(type).id
    }
    public var tid: TID {
        TID(type)
    }
    
    public var type: [Int]
    var noms: [String]
    
    var car: String?
    var use: String?
    var ext: String?

    
    var parent: Taxion {
        parent(type.count-1)
    }

    func parent(_ level:Int) -> Taxion {
        var parentab:[Int] = []
        var parenoms: [String] = []
        if level > 0 {
            for i in 0..<level {
                parentab.append(type[i])
                parenoms.append(noms[i])
            }
        }
        return Taxion( parentab, parenoms)
    }
    public init() {
        type = []
        noms = []
    }
    init(_ tab:[Int], _ noms:[String]) {
        type = tab
        self.noms = noms
    }
    //preview
    init(_ type:[Int], _ taxionomy:Taxionomy = Taxionomy.besoins) {
       self = taxionomy.find(TID(type))
    }
    
    func child(_ id:Int) -> Taxion {
        var childtype = type
            childtype.append(id)
        var childnoms = noms
            childnoms.append("")
        return Taxion( childtype, childnoms)
    }

    mutating func clear() {
        self = Taxion(type,noms)
    }
    mutating func changenom(_ string:String) {
        if dim > 0 {
            noms[dim-1] = string
        } else {
            noms = [string]
        }
    }
    public var nom:String {
        dim > 0 ? noms[dim-1] : "NaN"
    }
    public var short:String {
        dim > 1 ? noms[dim-2] + " " + nom : nom
    }

    public func complet(_ sep:String = " ") -> String {
        if dim > 0 {
            var string = noms[0]
            for n in 1..<dim {
                string = string + sep + noms[n]
            }
            return string
        } else {
            return "NaN"
        }
    }
    public var full : [String] {
        [complet(), car ?? "", use ?? ""]
    }
    
    var root: String {
        var string = ""
        if dim > 0 {
            for n in 0..<dim-1 {
                string = string + " " + noms[n]
            }
        }
        return string
    }
    
    var dim : Int { noms.count }
    
    var parentid : String { TID(parent.type).id }
   
}

