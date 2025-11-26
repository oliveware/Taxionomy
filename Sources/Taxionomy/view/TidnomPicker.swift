//
//  TidnomPicker.swift
//  Taxionomy
//
//  Created by Herve Crespel on 26/11/2025.
//

import SwiftUI

public struct TidnomPicker : View {
    var taxionomy : Taxionomy
    @Binding var idnom: Idnom
    @State var taxion: Taxion
    var done: () -> Void
    
    public init(_ idnom:Binding<Idnom>, _ taxionomie:Taxionomy, _ done: @escaping () -> Void) {
        _idnom = idnom
        taxion = taxionomie.find(idnom.wrappedValue.id)
        taxionomy = taxionomie
        self.done = done
    }
    
    public var body: some View {
        TaxionPicker($taxion, taxionomy, {
            idnom = Idnom(taxion)
            done()
        })
    }
}
