//
//  genre.swift
//  Taxionomy
//
//  Created by Herve Crespel on 10/12/2025.
//
import SwiftUI

public enum Genre : String, Codable {
    static var prompt = "genre"
    static var all : [Genre] = [.n,.f,.m]
    static let nbc = 3
    static var width : CGFloat = 100
    public var id: Self {self}
    
    case f = "féminin"
    case m = "masculin"
    case n = "neutre"
    
    // article indéfini
    var indéterminé:String {
        self == .f ? "une" : "un"
    }
    // article défini
    var déterminé:String {
        self == .f ? "la" : "le"
    }
    // article partitif
    func partitif(_ apostrophe:Bool = false,_ négatif:Bool = false) -> String {
        if négatif {
            if apostrophe {
                return "de"
            } else {
                return "d'"
            }
        } else {
            if apostrophe {
                return "de l'"
            } else {
                return self == .f ? "de la" : "du"
            }
        }
    }
    var démonstratif: String {
        self == .f ? "cette" : "ce"
    }
    var possessif:String {
        self == .f ? "sa" : "son"
    }
}

struct GenrePicker: View {
    @Binding var selected: Genre?
    
    var body:some View {
        Picker("", selection: $selected) {
            ForEach ( 0..<Genre.nbc, id:\.self) {
                i in
                let item = Genre.all[i]
                Text(item.rawValue).tag(item)
            }
        }
        .frame(width: Genre.width, height: 25, alignment: .leading)
    }
}
