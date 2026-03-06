package br.com.prototype.listacompras.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.prototype.listacompras.model.Usuario;


@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    
    boolean existsByEmail(String email);
}


    

