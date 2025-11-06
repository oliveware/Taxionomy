//
//  TaxionomieShow.swift
//  Taxion
//
//  Created by Herve Crespel on 06/11/2025.
//
import SwiftUI

struct TaxionomyShow : View {
    var taxionomy = Taxionomy.besoins
    
    var body: some View {
        ScrollView {
            
            ForEach (0..<taxionomy.levels.count, id:\.self) {
                index in
                ForEach (taxionomy.levels[index].items) {
                    taxion in
                    HStack {
                        Text(taxion.id).frame(width:150, alignment: .leading)
                        Text(taxion.complet())
                        Spacer()
                    }
                }
                HStack {
                    Text("------------  \(taxionomy.levels[index].items.count) taxions de niveau \(index + 1)").padding(.bottom,5)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    TaxionomyShow().padding()
}
