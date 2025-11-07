//
//  TaxionomyEditor.swift
//  Taxion
//
//  Created by Herve Crespel on 05/11/2025.
//

import SwiftUI

public struct TaxionomyEditor : View {
    @Binding var taxionomy : Taxionomy //(taxionomie)
    @State var taxion = Taxion()
    @State var picker = true
    @State var creation = false
    
    public init(_ taxionomie:Binding<Taxionomy>) {
        _taxionomy = taxionomie
    }
    
    public var body : some View {
        
        VStack {
            if picker {
                TaxionPicker($taxion, $taxionomy, {})
                
                HStack {
                    if taxion.dim > 0 {
                        Button("modifier", action: {
                            picker = false
                            creation = false})
                    }
                    Button("ajouter", action: {
                        picker = false
                        creation = true
                    })
                }
            } else {
                if creation {
                    TaxionCreator($taxion, create)
                } else {
                    TaxionEditor($taxion, maj)
                }
            }
        }
    }
    
    func create() {
        taxionomy.add(taxion)
        picker = true
    }
    
    func maj() {
        taxionomy.maj(taxion)
        picker = true
    }
    
    
}

struct TaxionomyPreditor : View {
    @State var taxionomy = Taxionomy(taxionomie2)
    
    var body : some View {
        TaxionomyEditor($taxionomy).frame(width:600, height:500)
    }
}

#Preview { TaxionomyPreditor() }
//#Preview { TaxionomyPreditor(taxion: Taxion([1,1,1])) }
