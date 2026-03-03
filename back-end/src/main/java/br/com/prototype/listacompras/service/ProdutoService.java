package br.com.prototype.listacompras.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.prototype.listacompras.dto.ProdutoRequestDTO;
import br.com.prototype.listacompras.dto.ProdutoResponseDTO;
import br.com.prototype.listacompras.model.Produto;
import br.com.prototype.listacompras.model.Categoria;
import br.com.prototype.listacompras.repository.ProdutoRepository;
import br.com.prototype.listacompras.repository.CategoriaRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProdutoService {

    @Autowired
    private ProdutoRepository produtoRepository;

    @Autowired
    private CategoriaRepository categoriaRepository;

    public List<ProdutoResponseDTO> listarTodos() {
        return produtoRepository.findAll()
                .stream()
                .map(this::converterParaDTO)
                .collect(Collectors.toList());
    }

    public ProdutoResponseDTO buscarPorId(Long id) {
        Produto produto = produtoRepository.findById(id).orElse(null);
        return produto != null ? converterParaDTO(produto) : null;
    }

    public ProdutoResponseDTO criar(ProdutoRequestDTO dto) {

        Categoria categoria = categoriaRepository.findById(dto.getCategoriaId())
                .orElseThrow(() -> new RuntimeException("Categoria não encontrada"));

        Produto produto = new Produto();
        produto.setNome(dto.getNome());
        produto.setCategoria(categoria);

        Produto salvo = produtoRepository.save(produto);

        return converterParaDTO(salvo);
    }

    public ProdutoResponseDTO atualizar(Long id, ProdutoRequestDTO dto) {

        Produto produto = produtoRepository.findById(id).orElse(null);
        if (produto == null) return null;

        Categoria categoria = categoriaRepository.findById(dto.getCategoriaId())
                .orElseThrow(() -> new RuntimeException("Categoria não encontrada"));

        produto.setNome(dto.getNome());
        produto.setCategoria(categoria);

        Produto atualizado = produtoRepository.save(produto);

        return converterParaDTO(atualizado);
    }

    public boolean deletar(Long id) {

        Produto produto = produtoRepository.findById(id).orElse(null);
        if (produto == null) return false;

        produtoRepository.delete(produto);
        return true;
    }

    private ProdutoResponseDTO converterParaDTO(Produto produto) {

        ProdutoResponseDTO dto = new ProdutoResponseDTO();

        dto.setId(produto.getId());
        dto.setNome(produto.getNome());
        dto.setCategoriaId(produto.getCategoria().getId());
        dto.setCategoriaNome(produto.getCategoria().getNome());

        return dto;
    }
}