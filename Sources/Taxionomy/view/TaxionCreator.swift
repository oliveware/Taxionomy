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
            Text(taxion.complet())
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
            if nom.count > 2 {
                Button("valider", action:{
                    taxion.noms.append(nom)
                    done()
                })
            }
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
