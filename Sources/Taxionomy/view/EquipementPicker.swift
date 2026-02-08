//
//  EquipementPicker.swift
//  Taxionomy
//
//  Created by Herve Crespel on 05/02/2026.
//

import SwiftUI

public struct EquipementPicker : View {
    @Binding var tidid:String
    var done: () -> Void
    @State var parentid : String
    var fonction : String
    @State private var pick = false
    
    public init(_ tidid:Binding<String>, _ fonction:String, _ done: @escaping () -> Void) {
        _tidid = tidid
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
    
    public var picker: some View {
        ScrollView {
            ForEach(children) { taxion in
                Button(action:{
                    if taxionomy.children(taxion.id).count == 0 {
                        tidid = taxion.id
                        pick = false
                        done()
                    } else {
                        parentid = taxion.id
                    }
                })
                {Text(taxion.nom).frame(width:100)}
            }
        }
    }
    
    public var body: some View {
        if pick { picker } else {
            HStack(spacing:10) {
                Text(taxionomy.find(tidid).nom)
                
                Button(action:{
                    pick = true
                    parentid = fonction
                })
                {Image(systemName: "pencil")}
            }.frame(height:50)
        }
    }
}

struct EquipementPickerOld : View {

    @Binding var equipement: Taxion
    var done: () -> Void
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
    public var picker: some View {
        ScrollView {
            ForEach(children) { taxion in
                Button(action:{
                    if taxionomy.children(taxion.id).count == 0 {
                        equipement = taxion
                        pick = false
                        done()
                    } else {
                        parentid = taxion.id
                    }
                })
                {Text(taxion.nom).frame(width:100)}
            }
        }
    }
    
    public var body: some View {
        ZStack {
            if pick { picker } else {
                HStack(spacing:10) {
                    Text($equipement.wrappedValue.nom)
                    
                    Button(action:{
                        pick = true
                        parentid = fonction
                    })
                    {Image(systemName: "pencil")}
                }.frame(height:50)
            }
        }
    }
}

struct EquipementPrepicker : View {
    @State var equipement = ""
    @State var fonction:String = "2-9-33"
    
    var body: some View {
        VStack {
            Text("Equipements d'une fonction").font(.title).padding()
           TextField("",text:$fonction).frame(width:100)
            EquipementPicker($equipement, fonction ,  {})
                Spacer()
        }.frame(width:300, height:250)
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
