//
//  TaxionShow.swift
//  Taxion
//
//  Created by Herve Crespel on 04/11/2025.
//

//
//  TaxionPicker.swift
//  Taxion
//
//  Created by Herve Crespel on 31/10/2025.
//

import SwiftUI

public struct TaxionShow : View {
    var taxionomy = Taxionomy(taxionomie)
    var taxion: Taxion
    
    public init(_ taxion:Taxion, _ taxionomie:Taxionomy) {
        self.taxion = taxion
        taxionomy = taxionomie

    }
    
    public init(_ taxion:Taxion) {
        self.taxion = taxion
    }
    
    public var body : some View {
        VStack(alignment:.leading) {
            Spacer()
            if taxion.dim == 0 {
                Text("\(taxionomy.nom ?? "type") non défini")
            } else {
                
                HStack {
                    Spacer()
                    Text(taxion.nom).font(.title)
                    Spacer()
                }
                if let car = taxion.car {
                    Text("caractéristiques").font(.caption)
                        .padding(.top, 10)
                    Text(car)
                }
                if let use = taxion.use {
                    Text("conseil d'utilisation").font(.caption)
                        .padding(.top, 10)
                    Text(use)
                }
            }
            Spacer()
        }.padding()
    }
}

struct TaxionPreshow : View {
    var taxionomy = Taxionomy(taxionomie)
    @State var taxion = Taxion()
    
    var body : some View {
        TaxionShow(taxion, taxionomy)
    }
}

#Preview { TaxionPreshow() }
#Preview { TaxionPreshow(taxion: Taxion([1,1,1])) }
