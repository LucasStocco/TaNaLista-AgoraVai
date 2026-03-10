 package br.com.prototype.listacompras.service;
 
 import java.util.HashMap;
 import java.util.Map;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.stereotype.Service;
 import br.com.prototype.listacompras.repository.ItemRepository;
 
 @Service
 public class FinanceiroService {
	 
	 @Autowired
	 private ItemRepository itemRepository;
	 
	 public Map<String, Object> gerarRelatorio() {
		 Map<String, Object> relatorio = new HashMap<>();
		 relatorio.put("porLista", itemRepository.consultarGastoPorLista());
		 relatorio.put("porCategoria", itemRepository.consultarGastoPorCategoria());
		 return relatorio;
	 }
 }