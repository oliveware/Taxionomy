// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI

public struct Manager : View {
    @State var taxionomy = Taxionomy(taxionomie2)
    @State var selected = 0
    
    @State var taxion = Taxion()
    
    public init() {}
    
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

#Preview {
    Manager()
}
