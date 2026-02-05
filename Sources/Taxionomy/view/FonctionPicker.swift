//
//  FonctionPicker.swift
//  Taxionomy
//
//  Created by Herve Crespel on 05/02/2026.
//

import SwiftUI

public struct FonctionPicker : View {
    var taxionomy : Taxionomy
    @Binding var fonction: Taxion
    var done: () -> Void = {}
    
    public init(_ fonction:Binding<Taxion>, _ taxionomie:Taxionomy = Taxionomy.besoins, _ parent:String, _ done: @escaping () -> Void) {
        _fonction = fonction
        taxionomy = taxionomie
        pick = fonction.wrappedValue.isNaN
        self.done = done
        
    }
        
    var children: [Taxion] {
        let taxion = taxionomy.find(fonction.tid)
        var liste : [Taxion] = []
        if taxion.dim < taxionomy.levels.count {
            let children = taxionomy.levels[taxion.dim].children(taxion)
            liste = taxion.dim > 2  ? children.sorted(by: <) : children
        }
        return liste
    }
    
    
    @State private var pick :Bool
    public var body: some View {
        VStack {
            if pick {
                HStack{
                    //  Text(taxion.id)
                    Text(fonction.nom)
                    Spacer()
                    Button(action:{
                        done()
                        pick = false
                    })
                    {Image(systemName: "pencil")}
                }.padding()
            } else {
                if children.count > 0 {
                    ScrollView {
                        ForEach(children) { selected in
                            Button(action:{
                                fonction = selected
                                pick = false
                            })
                            {Text(selected.nom).frame(width:100)}
                        }
                    }.frame(height:250, alignment:.leading)
                    //.padding(.leading, CGFloat(taxion.dim * 80))
                } else {
                    Text("aucun choix")
                }
                //  }.frame(width:600, height:300, alignment:.leading)
            }
        }.padding()
    }
}

struct FonctionPrepicker : View {
    @State var taxion = Taxion()
    
    var body: some View {
        FonctionPicker($taxion, Taxionomy.besoins, "2-9",  {})
    }
}

#Preview {
    FonctionPrepicker()
}
