//
//  Dico.swift
//  Taxionomy
//
//  Created by Herve Crespel on 10/02/2026.
//

var frenchdico = Dico()

public struct Dico {
    static var next = 0
    private static func num() -> Int {
        next += 1
        return next
    }
    
    var numots: [Numot] = []
    
    mutating func add(_ mot:Mot) {
        var found = false
        for numot in numots {
            if numot.mot == mot {
                found = true
                break
            }
        }
        if !found {
            numots.append(Numot(mot, Dico.num()))
        }
    }
    subscript(_ nom:String) -> Int {
        var found : Int = 0
        for numot in numots {
            if numot.nom == nom {
                found = numot.num
                break
            }
        }
        return found
    }
}

struct Numot {
    
    var mot: Mot
    var nom:String {mot.singulier}
    var num: Int
    
    init(_ mot: Mot, _ num:Int) {
        self.mot = mot
        self.num = num
    }
}
