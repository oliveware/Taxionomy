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
    @FocusState private var isFocused : Field?
    
    enum Field : Hashable {
        case nom
        case car
        case use
    }
    
    public init(_ taxion:Binding<Taxion>, _ done: @escaping () -> Void) {
        _taxion = taxion
        self.done = done
        isFocused = .nom
    }
    
    var titre: String {
        if taxion.dim == 0 {
            return "création d'une nouvelle catégorie"
        } else {
            return "création d'un élément dans \(taxion.complet())"
        }
    }
    
    public var body : some View {
        VStack {
            Text(titre)
                .font(.title)
                .padding()
            Form {
                TextField("nom", text:$nom).font(.title2)
                    .focused($isFocused, equals: .nom)
                    .onSubmit({isFocused = .car})
                
                TextField("caractéristiques", text:Binding<String> (
                    get: { taxion.car ?? "" },
                    set: { taxion.car = $0 == "" ? nil : $0 })
                ).focused($isFocused, equals: .car)
                
                TextField("conseils", text:Binding<String> (
                    get: { taxion.use ?? "" },
                    set: { taxion.use = $0 == "" ? nil : $0 })
                )
            }
            Button("valider", action:{
                taxion.noms.append(nom)
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
