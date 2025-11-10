//
//  TaxionCreator.swift
//  Taxion
//
//  Created by Herve Crespel on 05/11/2025.
//

import SwiftUI

public struct TaxionEditor : View {
    @Binding var taxion: Taxion
    @State var nom: String
    var done: () -> Void
    var children : Bool
    
    
    public init(_ taxion:Binding<Taxion>, _ children:Bool, _ done: @escaping () -> Void) {
        _taxion = taxion
        self.children = children
        self.done = done
        nom = taxion.wrappedValue.dim > 0 ? taxion.wrappedValue.nom : ""
    }
    
    public var body : some View {
        VStack {
            Form {
                if children {
                    Text(taxion.nom).font(.title2)
                } else {
                    TextField("nom", text:$nom).font(.title2)
                }

                TextField("caractéristiques", text:Binding<String> (
                    get: { taxion.car ?? "" },
                    set: { taxion.car = $0 == "" ? nil : $0 })
                )
                
                TextField("conseils", text:Binding<String> (
                    get: { taxion.use ?? "" },
                    set: { taxion.use = $0 == "" ? nil : $0 })
                )

            }
            Button("valider", action:{
                taxion.changenom(nom)
                done()
            }).disabled(nom.count < 3)
                .padding()
        }.padding()
        
    }
}

struct TaxionPreditor : View {
    @State var taxion = Taxion([1,2,12,22])
    func done() {}
    
    var body : some View {
        TaxionEditor($taxion, true, done)
    }
}

#Preview { TaxionPreditor(taxion:Taxion()) }
#Preview { TaxionPreditor() }
