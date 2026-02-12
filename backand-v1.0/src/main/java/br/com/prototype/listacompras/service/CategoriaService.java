package br.com.prototype.listacompras.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.prototype.listacompras.model.Categoria;
import br.com.prototype.listacompras.repository.CategoriaRepository;

import java.util.List;
import java.util.Optional;

@Service
public class CategoriaService {

    @Autowired
    private CategoriaRepository categoriaRepository;

    public List<Categoria> listarTodos() {
        return categoriaRepository.findAll();
    }

    public Optional<Categoria> buscarPorId(Long id) {
        return categoriaRepository.findById(id);
    }

    public Categoria criar(Categoria categoria) {
        return categoriaRepository.save(categoria);
    }

    public Categoria atualizar(Long id, Categoria categoriaAtualizada) {
        return categoriaRepository.findById(id)
                .map(categoria -> {
                    categoria.setNome(categoriaAtualizada.getNome());
                    return categoriaRepository.save(categoria);
                }).orElse(null);
    }

    public boolean deletar(Long id) {
        return categoriaRepository.findById(id)
                .map(categoria -> {
                    categoriaRepository.delete(categoria);
                    return true;
                }).orElse(false);
    }
}
