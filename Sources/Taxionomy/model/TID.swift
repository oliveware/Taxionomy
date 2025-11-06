//
//  TID.swift
//  Taxion
//
//
//  Created by Herve Crespel on 06/07/2025.
//

import Foundation

public struct TID : Codable, Identifiable, Equatable{
    
    var tab : [Int]
    var dim: Int { tab.count }
    
    public init() {
        tab = []
    }
    
    public init(_ tab:[Int]) {
        self.tab = tab
    }
    
    public var id: String {
        var t = ""
        if tab.count > 0 {
            t = String(tab[0])
            for i in 1..<tab.count {
                t = t + "-" + String(tab[i])
            }
        }
        return t
    }
    
    public func belongsto(_ parent:TID) -> Bool {
        if tab.count < 2 || parent.dim == 0 {
            return false
        } else {
            var parentab: [Int] = []
            for i in 0..<tab.count-2 {
                parentab.append(tab[i])
            }
            return TID(parentab).id == parent.id
        }
    }
    
    
    public static func == (a:TID, b:TID) -> Bool {
        a.id == b.id
    }
}











