//
//  TaxionPicker.swift
//  Taxion
//
//  Created by Herve Crespel on 31/10/2025.
//

//
//  TaxionView.swift
//  Taxonomy
//
//  Created by Herve Crespel on 30/10/2025.
//

import SwiftUI

public struct TaxionView : View {
    var taxionomy = Taxionomy(taxionomie2)
    @Binding var taxion: Taxion
    @State var picker = false
    @State var detail = false
    
    public init(_ taxion:Binding<Taxion>, _ taxionomie:Taxionomy) {
        _taxion = taxion
        taxionomy = taxionomie
    }
    
    public init(_ taxion:Binding<Taxion>) {
        _taxion = taxion
    }
    
    public var body : some View {
        VStack( alignment:.leading) {
            if picker {
                TaxionPicker($taxion, taxionomy, {}) //, {picker = false})
            } else {
                HStack {
                    if taxion.dim == 0 {
                        Text("choisir un type")
                    } else {
                        Text(taxion.complet())
                    }
                    Button(action: {picker = true})
                    {Image(systemName: "pencil")}
                }
            }
            
            Spacer()
        }.padding()
    }
}

struct TaxionPreview : View {
    var taxionomy = Taxionomy(taxionomie)
    @State var taxion = Taxion()
    
    var body : some View {
        TaxionView($taxion, taxionomy).frame(width:700,height:400)
    }
}

#Preview { TaxionPreview() }
#Preview { TaxionPreview(taxion: Taxion([1,1,1])) }
