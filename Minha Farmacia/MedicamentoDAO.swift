//
//  MedicamentoDAO.swift
//  Farmácia
//
//  Created by Kleiton Batista on 21/10/16.
//  Copyright © 2016 Kleiton Batista. All rights reserved.
//

import UIKit
import CoreData
class MedicamentoDAO: NSObject {
  /**
     Método responsável por armazenar os dados do medicamento do usuario no banco de dados
  */
    func gravarMedicamento(contexto: NSManagedObjectContext,medicamento: Medicamento){
        let medic = NSEntityDescription.insertNewObjectForEntityForName("Medicamento", inManagedObjectContext: contexto)
        let util = Util()
        medic.setValue(medicamento.id, forKey: "id_medicamento")
        medic.setValue(medicamento.apresentacao, forKey: "apresentacao")
        medic.setValue(medicamento.classeTerapeutica, forKey: "classe_terapeutica")
        medic.setValue(medicamento.codBarras, forKey: "cod_barras")
        medic.setValue(medicamento.laboratorio, forKey: "laboratorio")
        medic.setValue(medicamento.nome, forKey: "nome")
        medic.setValue(medicamento.principioAtivo, forKey: "principio_ativo")
        medic.setValue(util.convertImageToNSData(medicamento.fotoMedicamento), forKey: "foto_medicamento")
        
        do{
            try contexto.save()
            print("medicamento salvo")
        }catch{
            print("Erro ao salvar o medicamento")
        }
    }
    /**
        Verifica se existe medicamentos na base
     */
    func verificaExistenciaMedicamento(contexto: NSManagedObjectContext) -> Bool{
        let request = NSFetchRequest(entityName: "Medicamento")
        request.returnsObjectsAsFaults = false
        do{
           let results = try contexto.executeFetchRequest(request)
            print("->\(results)")
            return results.count != 0
        }catch{
            print("deu ruim")
            return false
        }
    }
    /**
        método responsavel por buscar todos os medicamentos que estao salvos no banco
     */
    func recuperarMedicamentos(contexto: NSManagedObjectContext) ->[Medicamento]{
        let request = NSFetchRequest(entityName: "Medicamento")
        request.returnsObjectsAsFaults = false
        var arrayMedicamento = [Medicamento]()
        let util = Util()
        let medicamento = Medicamento()
        do{
            let results = try contexto.executeFetchRequest(request)
            for result in results as! [NSManagedObject]{
                medicamento.id = result.valueForKey("id_medicamento") as! Int
                medicamento.apresentacao = result.valueForKey("apresentacao") as? String
                medicamento.classeTerapeutica = result.valueForKey("classe_terapeutica") as? String
                medicamento.codBarras = result.valueForKey("cod_barras") as? String
                medicamento.laboratorio = result.valueForKey("laboratorio") as? String
                medicamento.nome = result.valueForKey("nome") as? String
                medicamento.principioAtivo = result.valueForKey("principio_ativo") as? String
                medicamento.fotoMedicamento = util.convertNSDataToImage(result.valueForKey("foto_medicamento") as! NSData)
                arrayMedicamento.append(medicamento)
            }
            print("Leus os medicamentos")
        }catch{
            print("Erro ao buscar os medicamentos")
        }
        return arrayMedicamento
    }
    }
