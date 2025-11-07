// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI

public struct TaxionomyAPI : View {
    @Binding var taxionomy : Taxionomy
    @State var selected = 0
    
    public init(_ taxionomy:Binding<Taxionomy>) {
        _taxionomy = taxionomy
    }
    
    @State var taxion = Taxion()
    
    public var body: some View {
        TabView(selection: $selected) {
            TaxionomyShow(taxionomy: taxionomy)
                .tabItem { Text("liste") }.tag(1)
            TaxionPicker($taxion, $taxionomy, {})
                .tabItem { Text("picker") }.tag(2)
            TaxionomyEditor($taxionomy)
                .tabItem { Text("éditer") }.tag(3)
        }.padding()
    }
}

struct TaxionomyAPIpreview: View {
    @State var taxionomy = Taxionomy(taxionomie2)
    var body: some View {
        TaxionomyAPI($taxionomy)
    }
}

#Preview {
    TaxionomyAPIpreview()
}
