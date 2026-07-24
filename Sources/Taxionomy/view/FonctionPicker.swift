//
//  FonctionPicker.swift
//  Taxionomy
//
//  Created by Herve Crespel on 23/07/2026.
//

import SwiftUI

public struct FonctionPicker: View {
    @Binding var fonction:Taxion
    var choix:[Taxion] = []
    
    public init(_ fonction:Binding<Taxion>, _ exclude:[String]) {
        _fonction = fonction
        choix = Taxionomy.fonctions.filter {item in !exclude.contains(item.id)}
    }
    
    
    public var body: some View {
        VStack {
            if choix.count > 0 {
                ScrollView {
                    ForEach(choix) { selected in
                        Button(action:{
                            fonction = selected
                            //ajout = true
                            //done()
                        })
                        {Text(selected.nom).frame(width:100)}
                    }
                }.frame(height:220, alignment:.leading)
                //.padding(.leading, CGFloat(taxion.dim * 80))
            } else {
                Text("aucune fonction dans la taxonomie")
            }
        }.padding()
    }
}

struct FonctionPrepicker : View {
    @State var taxion = Taxion()
    var exclude: [String] = ["2-9-37", "2-9-34", "2-9-36"]
    
    var body: some View {
        VStack {
            Text("Fonctions").font(.title2)
            FonctionPicker($taxion, exclude)
            Text(taxion.id)
            Text(taxion.nom)
        }.frame(width:180, height:300).padding()
    }
}

#Preview {
    HStack(spacing:20) {
        GroupBox("all") {
            FonctionPrepicker(exclude:[])
        }
        GroupBox("exclusion") {
            FonctionPrepicker()
        }
    }.padding()
}
