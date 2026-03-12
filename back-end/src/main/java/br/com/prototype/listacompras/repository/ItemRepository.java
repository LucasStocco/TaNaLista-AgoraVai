package br.com.prototype.listacompras.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import br.com.prototype.listacompras.model.Item;
import br.com.prototype.listacompras.model.Financeiro;

   

public interface ItemRepository extends JpaRepository<Item, Long> {

    List<Item> findByListaId(Long listaId);
    
   
   @Query("SELECT 1.nome as nomeLista, SUM(i.preco * i.quantidade) as totalGasto " + "FROM Item i JOIN i.Lista 1 GROUP BY 1.nome")
   List<Financeiro.GastoPorLista> consultarGastoPorLista();
   
   @Query("SELECT c.nome as nomeCategoria, SUM(i.preco * i.quantidade) as totalGasto " + "FROM Item i JOIN i.produto p JOIN p.categoria c GROUP BY c.nome")
   List<Financeiro.GastoPorCategoria> consultarGastoPorCategoria(); 
   
   
}
