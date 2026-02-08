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
        case edit
        case delete
    }
    
    public init(_ taxionomie:Binding<Taxionomy>) {
        _taxionomy = taxionomie
    }
    
    var children: Bool {
        !taxionomy.children(taxion).isEmpty
    }
    
    public var body : some View {
        VStack {
            if taxionomy.dim > 0 {
                Text(taxion.root)
                Spacer()
                switch action {
                case .pick :
                    HStack {
                        TaxionMaker($taxion, $taxionomy)
                        Spacer()
                        VStack {
                            Spacer()
                            if !children {
                                Button("supprimer", action: { action = .delete })
                            }
                            if taxion.dim > 0 {
                                Button("modifier", action: { action = .edit })
                            }
                            
                            if taxion.dim <= taxionomy.dim {
                                Button("ajouter", action: {
                                    taxion = taxionomy.add(taxion)
                                    action = .edit
                                })
                            }
                            Spacer()
                        }
                    }
                case .edit :
                    TaxionEditor($taxion, children, maj)
                case .delete :
                    Text("confirmer la suppression de \(taxion.label)").font(.title)
                        .padding(20)
                    HStack {
                        Button("annuler", action: { action = .pick })
                        Button("confirmer", action: { delete() })
                    }
                }
                Spacer()
            } else {
                Text ("Création d'une taxionomie").font(.title)
                Button("premier élément", action: {
                    taxion = Taxion([1],[""])
                    taxionomy.levels = [Taxions(taxion)]
                    action = .edit
                })
            }
        }.padding()
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

#Preview("édition") { TaxionomyPreditor() }
#Preview("création") { TaxionomyPreditor(taxionomy: Taxionomy()) }
