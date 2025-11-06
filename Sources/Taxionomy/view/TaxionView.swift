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
    @State var taxionomy = Taxionomy(taxionomie)
    @Binding var taxion: Taxion
    @State var edition: Bool = false
    @State var picker = false
    
    public init(_ taxion:Binding<Taxion>, _ taxionomie:Taxionomy) {
        _taxion = taxion
        taxionomy = taxionomie
    }
    
    public init(_ taxion:Binding<Taxion>) {
        _taxion = taxion
    }
    
    public var body : some View {
        VStack( alignment:.leading) {
            
                if edition {
                    if picker {
                        HStack(alignment: .top) {
                            TaxionPicker($taxion, $taxionomy, {picker = false})
                            if taxion.dim > 0 {
                                Button(action: {picker = false})
                                {Image(systemName: "checkmark")}
                            }
                        }
                    } else {
                        HStack {
                            Text(taxion.complet())
                            Button(action: {picker = true})
                            {Image(systemName: "pencil")}
                        }
                        
                        HStack {
                            TaxionCreator($taxion, {})
                            Button(action: {edition = false})
                            {Image(systemName: "checkmark")}
                        }
                    }
                } else {
                    HStack {
                        TaxionShow(taxion)
                        Button(action: {edition = true})
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
        TaxionView($taxion, taxionomy)
    }
}

#Preview { TaxionPreview() }
#Preview { TaxionPreview(taxion: Taxion([1,1,1])) }
