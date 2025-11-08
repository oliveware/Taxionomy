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
    @State var action = Step.pick
    
    enum Step {
        case pick
        case create
        case maj
        case delete
    }
    
    public init(_ taxionomie:Binding<Taxionomy>) {
        _taxionomy = taxionomie
    }
    
    public var body : some View {
        
        VStack {
            if taxion.dim > 0 { Text(taxion.root) }
            Spacer()
            switch action {
            case .pick :
                 //, {action = .action})
                HStack {
                    TaxionPicker($taxion, $taxionomy)
                    Spacer()
                    VStack {
                        Spacer()
                        if taxion.dim > 0 {
                            if taxionomy.children(taxion).isEmpty {
                                Button("supprimer", action: { action = .delete })
                            }
                            Button("modifier", action: { action = .maj })
                        }
                        if taxion.dim < 6 {
                            Button("ajouter", action: {
                                taxion.clear()
                                action = .create
                            })
                        }
                        Spacer()
                    }
                }
            case .create :
                TaxionCreator($taxion, create)
            case .maj :
                TaxionEditor($taxion, maj)
            case .delete :
                Text("confirmer la suppression de \(taxion.nom)").font(.title)
                    .padding(20)
                HStack {
                    Button("annuler", action: { action = .pick })
                    Button("confirmer", action: { delete() })
                }
            }
            Spacer()
        }.padding()
    }
    
    func create() {
        taxion = taxionomy.add(taxion)
        action = .pick
    }
    
    func maj() {
        taxionomy.maj(taxion)
        action = .pick
    }
    
    func delete() {
        let parent = taxion.parent
        taxionomy.delete(taxion)
        taxion = parent
        action = .pick
    }
    
    
}

struct TaxionomyPreditor : View {
    @State var taxionomy = Taxionomy(taxionomie2)
    
    var body : some View {
        TaxionomyEditor($taxionomy).frame(width:800, height:500)
    }
}

#Preview { TaxionomyPreditor() }
//#Preview { TaxionomyPreditor(taxion: Taxion([1,1,1])) }
