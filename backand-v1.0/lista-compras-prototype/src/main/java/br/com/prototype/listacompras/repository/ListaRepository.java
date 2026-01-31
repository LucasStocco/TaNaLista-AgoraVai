package br.com.prototype.listacompras.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.prototype.listacompras.model.Lista;

@Repository
public interface ListaRepository extends JpaRepository<Lista, Long> {
}
