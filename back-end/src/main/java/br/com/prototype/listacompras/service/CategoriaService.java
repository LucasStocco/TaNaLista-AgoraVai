package br.com.prototype.listacompras.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.prototype.listacompras.dto.CategoriaRequestDTO;
import br.com.prototype.listacompras.dto.CategoriaResponseDTO;
import br.com.prototype.listacompras.model.Categoria;
import br.com.prototype.listacompras.repository.CategoriaRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoriaService {

    @Autowired
    private CategoriaRepository categoriaRepository;

    public List<CategoriaResponseDTO> listarTodos() {
        return categoriaRepository.findAll()
                .stream()
                .map(this::converterParaDTO)
                .collect(Collectors.toList());
    }

    public CategoriaResponseDTO buscarPorId(Long id) {
        Categoria categoria = categoriaRepository.findById(id).orElse(null);
        return categoria != null ? converterParaDTO(categoria) : null;
    }

    public CategoriaResponseDTO criar(CategoriaRequestDTO dto) {

        Categoria categoria = new Categoria();
        categoria.setNome(dto.getNome());

        Categoria salva = categoriaRepository.save(categoria);

        return converterParaDTO(salva);
    }

    public CategoriaResponseDTO atualizar(Long id, CategoriaRequestDTO dto) {

        Categoria categoria = categoriaRepository.findById(id).orElse(null);

        if (categoria == null) return null;

        categoria.setNome(dto.getNome());

        Categoria atualizada = categoriaRepository.save(categoria);

        return converterParaDTO(atualizada);
    }

    public boolean deletar(Long id) {

        Categoria categoria = categoriaRepository.findById(id).orElse(null);

        if (categoria == null) return false;

        categoriaRepository.delete(categoria);
        return true;
    }

    private CategoriaResponseDTO converterParaDTO(Categoria categoria) {

        CategoriaResponseDTO dto = new CategoriaResponseDTO();
        dto.setId(categoria.getId());
        dto.setNome(categoria.getNome());

        return dto;
    }
}