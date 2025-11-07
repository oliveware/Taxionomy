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
        case action
        case create
        case maj
        case delete
    }
    
    public init(_ taxionomie:Binding<Taxionomy>) {
        _taxionomy = taxionomie
    }
    
    public var body : some View {
        
        VStack {
            if action != .pick && taxion.dim > 0 {
                HStack {
                    Text(taxion.root)
                }
            }
            switch action {
            case .pick :
                TaxionPicker($taxion, $taxionomy, {action = .action})
            case .action:
                TaxionShow(taxion)
                HStack {
                    if taxion.dim >= 0 {
                        Button("choisir un autre type", action: { action = .pick })
                        Spacer()
                        Button("supprimer", action: { action = .delete })
                        Button("modifier", action: { action = .maj })
                        if taxion.dim < 6 {
                            Button("ajouter", action: { action = .create })
                        }
                        Spacer()
                    }
                }
            case .create :
                TaxionCreator($taxion, create)
            case .maj :
                TaxionEditor($taxion, maj)
            case .delete :
                Button("confirmer la suppression de \(taxion.nom)", action: { delete() })
            }
           
        }.padding()
    }
    
    func create() {
        taxionomy.add(taxion)
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
        TaxionomyEditor($taxionomy).frame(width:600, height:500)
    }
}

#Preview { TaxionomyPreditor() }
//#Preview { TaxionomyPreditor(taxion: Taxion([1,1,1])) }
