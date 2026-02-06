//
//  TaxionEditor.swift
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
    var previous: Taxion
    
    
    public init(_ taxion:Binding<Taxion>, _ children:Bool, _ done: @escaping () -> Void) {
        _taxion = taxion
        previous = taxion.wrappedValue
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
                
                TextField("label", text:Binding<String> (
                    get: { taxion.nomlong ?? taxion.concat + " " + nom },
                    set: { taxion.nomlong = $0 == "" ? nil : $0 })
                )

                TextField("caractéristiques", text:Binding<String> (
                    get: { taxion.car ?? "" },
                    set: { taxion.car = $0 == "" ? nil : $0 })
                )
                
                TextField("conseils", text:Binding<String> (
                    get: { taxion.use ?? "" },
                    set: { taxion.use = $0 == "" ? nil : $0 })
                )
                
                TextField("extension", text:Binding<String> (
                    get: { taxion.ext ?? "" },
                    set: { taxion.ext = $0 == "" ? nil : $0 })
                ).frame(width:220)
            }
            HStack {
                Button("annuler", action:{
                    taxion = previous
                    done()
                })
                Button("valider", action:{
                    taxion.changenom(nom)
                    done()
                }).disabled(nom.count < 3)
                    .padding()
            }
        }.padding()
        
    }
}

struct TaxionPreditor : View {
    @State var taxion = Taxion([1,2,15,47])
    func done() {}
    
    var body : some View {
        TaxionEditor($taxion, true, done)
    }
}

#Preview { TaxionPreditor(taxion:Taxion()) }
#Preview { TaxionPreditor() }
