//
//  EquipementPicker.swift
//  Taxionomy
//
//  Created by Herve Crespel on 05/02/2026.
//

import SwiftUI

public struct EquipementPicker : View {

    @Binding var equipement: Taxion
    var done: () -> Void = {}
    @State var parentid : String
    var fonction : String
    
    public init(_ equipement:Binding<Taxion>, _ fonction:String, _ done: @escaping () -> Void) {
        _equipement = equipement
        pick = equipement.wrappedValue.isNaN
        self.done = done
        self.fonction = fonction
        parentid = fonction
    }
    var taxionomy:Taxionomy {Taxionomy.besoins}
        
    var children : [Taxion] {
        let taxion = taxionomy.find(parentid)
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
                if children.count > 0 {
                    ScrollView {
                        ForEach(children) { selected in
                            Button(action:{
                                if taxionomy.children(selected.id).count == 0 {
                                    equipement = selected
                                    pick = false
                                } else {
                                    parentid = selected.id
                                }
                            })
                            {Text(selected.nom).frame(width:100)}
                        }
                    }.frame(height:250, alignment:.leading)
                    //.padding(.leading, CGFloat(taxion.dim * 80))
                } else {
                    Text("aucun choix")
                }
                
            } else {
                HStack{
                    //  Text(taxion.id)
                    Text(equipement.nom)
                    Spacer()
                    Button(action:{
                        done()
                        pick = true
                        parentid = fonction
                    })
                    {Image(systemName: "pencil")}
                }.padding()
                //  }.frame(width:600, height:300, alignment:.leading)
            }
        }.padding()
    }
}

struct EquipementPrepicker : View {
    @State var equipement = Taxion()
    @State var fonction:String = "2-9-33"
    
    var body: some View {
        VStack {
            Text("Equipements d'une fonction").font(.title).padding()
            TextField("",text:$fonction).frame(width:100)
            EquipementPicker($equipement, fonction ,  {})
                .frame(width:300, height:300)
        }
    }
}

#Preview ("cuisson") {
    EquipementPrepicker()
}

#Preview ("froid") {
    EquipementPrepicker(fonction:"2-9-34")
}
#Preview ("sanitaire") {
    EquipementPrepicker(fonction:"2-9-38")
}
