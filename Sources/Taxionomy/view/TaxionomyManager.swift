//
//  Untitled.swift
//  Taxionomy
//
//  Created by Herve Crespel on 07/11/2025.
//


import SwiftUI

public struct TaxionomyManager : View {
    @Binding var taxionomy : Taxionomy
    @State var selected = 0
    
    public init(_ taxionomy:Binding<Taxionomy>) {
        _taxionomy = taxionomy
    }
    
    @State var taxion = Taxion()
    
    public var body: some View {
        HSplitView {
            TaxionomyEditor($taxionomy)
            TaxionomyShow(taxionomy: taxionomy)
        }.padding()
    }
}

struct TaxiomanagerPreview: View {
    @State var taxionomy = Taxionomy(taxionomie2)
    var body: some View {
        TaxionomyManager($taxionomy)
    }
}

#Preview {
    TaxiomanagerPreview().frame(width:1200)
}
