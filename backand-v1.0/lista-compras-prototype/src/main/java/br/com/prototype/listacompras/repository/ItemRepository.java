package br.com.prototype.listacompras.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.prototype.listacompras.model.Item;

public interface ItemRepository extends JpaRepository<Item, Long> {

    List<Item> findByListaId(Long listaId);
}
