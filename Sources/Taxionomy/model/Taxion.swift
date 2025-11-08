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
    var detail: String? // dans une taxionomie spécialisée
    var imagurl: String?
    var contenturl: String?
    
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
    init(_ type:[Int]) {
        let tid = TID(type)
        let level = Taxionomy.besoins.levels[type.count - 1]
        self = level[tid.id]
    }
   /* public init(_ tid:TID) {
        let col = Taxions.cols[tid.tab.count - 1]
        self = col[tid.id]
    }*/
    mutating func clear() {
        self = Taxion(type,noms)
        /*car = nil
        use = nil
        detail = nil
        imagurl = nil
        contenturl = nil*/
    }
    mutating func changenom(_ string:String) {
        if dim > 0 {
            noms[dim-1] = string
        } else {
            noms = [string]
        }
    }
    var nom:String {
        dim > 0 ? noms[dim-1] : "NaN"
    }
    var short:String {
        dim > 2 ? noms[dim-2] + " " + nom : nom
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
    var dim : Int { noms.count }
    
    var parentid : String { TID(parent.type).id }
   
}

