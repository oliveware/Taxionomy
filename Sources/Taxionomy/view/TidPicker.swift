//
//  TIDPicker.swift
//  Taxionomy
//
//  Created by Herve Crespel on 20/11/2025.
//
import SwiftUI

public struct TidPicker : View {
    var taxionomy : Taxionomy
    @Binding var tid: String
    @State var taxion: Taxion
    var done: () -> Void
    
    public init(_ tid:Binding<String>, _ taxionomie:Taxionomy, _ done: @escaping () -> Void) {
        _tid = tid
        taxion = taxionomie.find(tid.wrappedValue)
        taxionomy = taxionomie
        self.done = done
    }
    
    public var body: some View {
        TaxionPicker($taxion, taxionomy, {
            tid = taxion.id
            done()
        })
    }
}
