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
    
    
    public init(_ taxion:Binding<Taxion>, _ done: @escaping () -> Void) {
        _taxion = taxion
        self.done = done
        nom = taxion.wrappedValue.dim > 0 ? taxion.wrappedValue.nom : ""
    }
    
    public var body : some View {
        VStack {
            Form {
                TextField("nom", text:$nom)

                TextField("caractéristiques", text:Binding<String> (
                    get: { taxion.car ?? "" },
                    set: { taxion.car = $0 })
                )
                
                TextField("conseils", text:Binding<String> (
                    get: { taxion.use ?? "" },
                    set: { taxion.use = $0 })
                )
            }
            Button("valider", action:{
                taxion.changenom(nom)
                done()
            })
        }.padding()
        
    }
}

struct TaxionPreditor : View {
    @State var taxion = Taxion([1,2,12,22])
    func done() {}
    
    var body : some View {
        TaxionEditor($taxion, done)
        TaxionShow(taxion)
    }
}

#Preview { TaxionPreditor(taxion:Taxion()) }
#Preview { TaxionPreditor() }
