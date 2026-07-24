//
//  FonctionPicker.swift
//  Taxionomy
//
//  Created by Herve Crespel on 05/02/2026.
//

import SwiftUI

public struct EquipementPicker : View {

    @Binding var fonction: Taxion
    @Binding var equipements: [Taxion]
    var done: () -> Void = {}
    var fonctions:[Taxion] = []
    var mot = Mot("équipement", "équipements", .m)
    
    public init(_ fonction:Binding<Taxion>,_ equipements:Binding<[Taxion]>, _ foncids:[String], _ include:Bool, _ done: @escaping () -> Void) {
        _fonction = fonction
        fonctionpick = fonction.wrappedValue.isNaN
        _equipements = equipements
        self.done = done
        
        if include {
            for tidid in foncids {
                fonctions.append(taxionomy.find(tidid))
            }
        } else {
            fonctions = Taxionomy.fonctions.filter {item in !foncids.contains(item.id)}
        }
    }
    
    @State var fonctionpick : Bool
    var pick: some View {
        VStack {
            if fonctions.count > 0 {
                ScrollView {
                    ForEach(fonctions) { selected in
                        Button(action:{
                            fonction = selected
                            ajout = true
                            done()
                            fonctionpick = false
                        })
                        {Text(selected.label).frame(width:100)}
                    }
                }.frame(height:220, alignment:.leading)
                //.padding(.leading, CGFloat(taxion.dim * 80))
            } else {
                Text("aucune fonction")
            }
        }.padding()
    }
    
    var taxionomy:Taxionomy {Taxionomy.besoins}
    
    func choisiréquipement() -> Void {
        let taxion = taxionomy.find(tidid)
        equipements.append(taxion)
        tidid = ""
        ajout = false
    }
    
    @State var tidid:String = ""
    @State var ajout = false
    var equipementpick: some View {
        VStack {
            TidChildrenPicker($tidid, fonction.id, mot, choisiréquipement)
            if equipements.count > 0 {
                Button("annuler", action:{ ajout = false })
            }
        }
    }
    
    @State var suppression = false
    func delete(_ taxion:Taxion) {
        var new : [Taxion] = []
        for equipement in equipements {
            if equipement.id != taxion.id { new.append(equipement) }
        }
        equipements = new
    }
    
    public var body: some View {
        VStack {
            if fonctionpick {
                pick
            } else {
                if ajout {
                    HStack {
                        Text("ajouter \(mot.indéterminé) de ")
                        Button(action:{fonctionpick = true})
                        { Text(fonction.nom) }
                    }
                }
                if equipements.count > 0 {
                   // ScrollView {
                        ForEach($equipements) { selected in
                            HStack {
                                if suppression {
                                    Button(action:{ delete(selected.wrappedValue) })
                                    { Image(systemName: "minus").foregroundColor(.pink) }
                                }
                                Text(selected.wrappedValue.label).frame(width:100)
                            }
                        }
                    //}.frame(alignment:.leading)
                }
                if ajout { equipementpick } else {
                    Spacer()
                    HStack {
                        Button(action:{ suppression.toggle() })
                        { Image(systemName: "minus").foregroundColor(.pink) }
                        Spacer()
                        Button(action:{
                            ajout = true
                            suppression = false
                        })
                        {Image(systemName: "plus")}
                        //{Text("ajouter \(mot.indéterminé)")}
                    }.padding()
                }
            }
        }
    }
}

struct EquipementPrepicker : View {
    @State var taxion = Taxion()
    @State var equipements : [Taxion] = []
    var tidids: [String] = ["2-9-37", "2-9-34", "2-9-36"]
    var include = false
    
    var body: some View {
        VStack {
            Text("Equipements").font(.title).padding()
            EquipementPicker($taxion, $equipements, tidids, include,  {})
            //Text(taxion.id)
           // Text(taxion.nom)
        }.frame(width:180, height:280).padding()
    }
}

#Preview {
    HStack(spacing:20) {
        GroupBox("all") {
            EquipementPrepicker(tidids:[])
        }
        GroupBox("exclusion") {
            EquipementPrepicker()
        }
        GroupBox("selection") {
            EquipementPrepicker(include:true)
        }
    }.padding()
}

