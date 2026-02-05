//
//  TaxionMaker.swift
//  Taxion
//
//  Created by Herve Crespel on 04/11/2025.
//

import SwiftUI

public struct TaxionMaker : View {
    @Binding var taxionomy : Taxionomy
    @Binding var taxion: Taxion
    @State var choix:[Taxion]
   // var done: () -> Void
    
    @State var pick = false
    
    public init(_ taxion:Binding<Taxion>, _ taxionomie:Binding<Taxionomy>) {//}, _ done: @escaping () -> Void) {
        _taxion = taxion
        _taxionomy = taxionomie
       // self.done = done
        let selected = taxion.wrappedValue
        choix = selected.dim == 0 ? taxionomie.wrappedValue.zero :
        taxionomie.wrappedValue.levels[selected.dim - 1].children(selected)
    }
    
    func select() {
        choix = children(taxion)
    }
    var barre : some View {
        VStack {
            if taxion.dim > 0 {
                Button(taxion.noms[0], action:{
                    taxion = Taxion()
                    choix = taxionomy.zero
                })
            }
            if taxion.dim > 1 {
                Button(taxion.noms[1], action:{
                    taxion = taxion.parent(1)
                    select()
                })
            }
            if taxion.dim > 2 {
                Button(taxion.noms[2], action:{
                    taxion = taxion.parent(2)
                    select()
                })
            }
            if taxion.dim > 3 {
                Button(taxion.noms[3], action:{
                    taxion = taxion.parent(3)
                    select()
                })
            }
            if taxion.dim > 4 {
                Button(taxion.noms[4], action:{
                    taxion = taxion.parent(4)
                    select()
                })
            }
            if taxion.dim > 5 {
                Button(taxion.noms[5], action:{
                    taxion = taxion.parent(5)
                    select()
                })
            }
            
            Spacer()
            Text(taxion.id)
           
        }
    }
    
    func children (_ taxion:Taxion) -> [Taxion] {
        var liste : [Taxion] = []
        if taxion.dim < taxionomy.levels.count {
            let children = taxionomy.levels[taxion.dim].children(taxion)
            liste = taxion.dim > 2  ? children.sorted(by: <) : children
        }
        return liste
    }
    
    public var body : some View {
        HStack( alignment:.top) {
                barre
                
                if choix.count > 0 {
                    ScrollView {
                        ForEach($choix) { selected in
                            Button(action:{
                                taxion = selected.wrappedValue
                                choix = children(selected.wrappedValue)
                            })
                            {Text(selected.wrappedValue.nom).frame(width:100)}
                        }
                    }.frame(height:250, alignment:.leading)
                    //.padding(.leading, CGFloat(taxion.dim * 80))
                }
                
                Spacer()
                TaxionShow(taxion)
                Spacer()
        }.frame(width:600, height:300, alignment:.leading)
            .padding()
    }
}

struct TaxionPremaker : View {
    //@State var taxionomy = Taxionomy(taxionomie2)
    @State var taxionomy = Taxionomy(URL(string:"http://192.168.1.41/dodata/besoins.taxionomie")!)
    @State var taxion = Taxion()
    
    var body : some View {
        TaxionMaker($taxion, $taxionomy)
    }
}

#Preview { TaxionPremaker() }
#Preview { TaxionPremaker(taxion: Taxion([1,1,1])) }

