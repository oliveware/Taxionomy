//
//  EquipementPicker.swift
//  Taxionomy
//
//  Created by Herve Crespel on 05/02/2026.
//

import SwiftUI

public struct TidChildrenPicker : View {
    @Binding var tidid:String
    var done: () -> Void
    @State var current : String
    var parent : String
    var mot: Mot
    @State private var pick = false
    
    public init(_ tidid:Binding<String>, _ parent:String,_ mot:Mot, _ done: @escaping () -> Void) {
        _tidid = tidid
        self.done = done
        self.parent = parent
        current = parent
        self.mot = mot
    }
    
    var taxionomy:Taxionomy {Taxionomy.besoins}
        
    var children : [Taxion] {
        let taxion = taxionomy.find(current)
        var liste : [Taxion] = []
        if taxion.dim < taxionomy.levels.count {
            let children = taxionomy.levels[taxion.dim].children(taxion)
            liste = taxion.dim > 2  ? children.sorted(by: <) : children
        }
        return liste
    }
    
    public var picker: some View {
        ScrollView {
            ForEach(children) { taxion in
                Button(action:{
                    if taxionomy.children(taxion.id).count == 0 {
                        tidid = taxion.id
                        pick = false
                        done()
                    } else {
                        current = taxion.id
                    }
                })
                {Text(taxion.label).frame(width:100)}
            }
        }
    }
    
    public var body: some View {
        if pick { picker } else {
            HStack(spacing:10) {
                if tidid == "" {
                    Text("choisir \(mot.indéterminé)")
                } else {
                    Text(taxionomy.find(tidid).nom)
                }
                Button(action:{
                    pick = true
                    current = parent
                })
                {Image(systemName: "pencil")}
            }.frame(height:50)
        }
    }
}

struct TidChildrenPrepicker : View {
    @State var tidid = ""
    @State var parent:String = "2-9-33"
    var mot = Mot("chose", "choses", .f)
    
    var nomparent:String {Taxionomy.besoin(TID(parent)).nom}
    
    var body: some View {
        VStack {
            Text("\(mot.pluriel) de \(nomparent)").font(.title).padding()
           TextField("",text:$parent).frame(width:100)
            TidChildrenPicker($tidid, parent , mot, {})
                Spacer()
        }.frame(width:300, height:250)
    }
}

#Preview ("cuisson") {
    TidChildrenPrepicker()
}

#Preview ("froid") {
    TidChildrenPrepicker(parent:"2-9-34")
}
#Preview ("sanitaire") {
    TidChildrenPrepicker(parent:"2-9-38")
}
