//
//  TaxionCreator.swift
//  Taxion
//
//  Created by Herve Crespel on 05/11/2025.
//

import SwiftUI

public struct TaxionCreator : View {
    @Binding var taxion: Taxion
    @State var nom: String = ""
    var done: () -> Void
    
    public init(_ taxion:Binding<Taxion>, _ done: @escaping () -> Void) {
        _taxion = taxion
        self.done = done
    }
    
    public var body : some View {
        VStack {
            Text("création d'un élément dans \(taxion.complet())")
                .font(.title)
                .padding()
            Form {
                TextField("nom", text:$nom).font(.title2)

                TextField("caractéristiques", text:Binding<String> (
                    get: { taxion.car ?? "" },
                    set: { taxion.car = $0 == "" ? nil : $0 })
                )
                
                TextField("conseils", text:Binding<String> (
                    get: { taxion.use ?? "" },
                    set: { taxion.use = $0 == "" ? nil : $0 })
                )
                TextField("image", text:Binding<String> (
                    get: { taxion.imagurl ?? "" },
                    set: { taxion.imagurl = $0 == "" ? nil : $0 })
                )
                .padding(.bottom,20)
                TextField("détail", text:Binding<String> (
                    get: { taxion.detailurl ?? "" },
                    set: { taxion.detailurl = $0 == "" ? nil : $0 })
                )
                TextField("sous-catégorie", text:Binding<String> (
                    get: { taxion.sub ?? "" },
                    set: { taxion.sub = $0 == "" ? nil : $0 })
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

struct TaxionPreator : View {
    @State var taxion = Taxion()
    func done() {}
    
    var body : some View {
        TaxionCreator($taxion, done)
        TaxionShow(taxion)
    }
}

#Preview { TaxionPreator() }
