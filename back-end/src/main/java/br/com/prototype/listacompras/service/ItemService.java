package br.com.prototype.listacompras.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.prototype.listacompras.dto.ItemRequestDTO;
import br.com.prototype.listacompras.dto.ItemResponseDTO;
import br.com.prototype.listacompras.model.Item;
import br.com.prototype.listacompras.model.Lista;
import br.com.prototype.listacompras.model.Categoria;
import br.com.prototype.listacompras.repository.ItemRepository;
import br.com.prototype.listacompras.repository.ListaRepository;
import br.com.prototype.listacompras.repository.CategoriaRepository;

@Service
public class ItemService {

    @Autowired
    private ItemRepository itemRepository;

    @Autowired
    private ListaRepository listaRepository;

    @Autowired
    private CategoriaRepository categoriaRepository;

    // ---------------- CREATE ----------------
    public ItemResponseDTO criar(Long listaId, ItemRequestDTO dto) {

        Lista lista = listaRepository.findById(listaId)
                .orElseThrow(() -> new RuntimeException("Lista não encontrada"));

        Item item = new Item();
        item.setNome(dto.getNome());
        item.setDescricao(dto.getDescricao());
        item.setPreco(dto.getPreco());
        item.setQuantidade(dto.getQuantidade());
        item.setLista(lista);

        if (dto.getCategoriaId() != null) {
            Categoria categoria = categoriaRepository.findById(dto.getCategoriaId())
                    .orElseThrow(() -> new RuntimeException("Categoria não encontrada"));
            item.setCategoria(categoria);
        }

        item.setComprado(dto.getComprado() != null ? dto.getComprado() : false);

        Item salvo = itemRepository.save(item);

        return converterParaDTO(salvo);
    }

    // ---------------- READ ALL ----------------
    public List<ItemResponseDTO> listarPorLista(Long listaId) {

        return itemRepository.findByListaId(listaId)
                .stream()
                .map(this::converterParaDTO)
                .collect(Collectors.toList());
    }

    // ---------------- READ ONE ----------------
    public ItemResponseDTO buscarPorId(Long listaId, Long itemId) {

        Item item = itemRepository.findById(itemId)
                .orElse(null);

        if (item == null || !item.getLista().getId().equals(listaId)) {
            return null;
        }

        return converterParaDTO(item);
    }

    // ---------------- UPDATE ----------------
    public ItemResponseDTO atualizar(Long listaId, Long id, ItemRequestDTO dto) {

        Item item = itemRepository.findById(id)
                .orElse(null);

        if (item == null || !item.getLista().getId().equals(listaId)) {
            return null;
        }

        item.setNome(dto.getNome());
        item.setDescricao(dto.getDescricao());
        item.setPreco(dto.getPreco());
        item.setQuantidade(dto.getQuantidade());

        if (dto.getCategoriaId() != null) {
            Categoria categoria = categoriaRepository.findById(dto.getCategoriaId())
                    .orElseThrow(() -> new RuntimeException("Categoria não encontrada"));
            item.setCategoria(categoria);
        } else {
            item.setCategoria(null);
        }

        if (dto.getComprado() != null) {
            item.setComprado(dto.getComprado());
        }

        Item atualizado = itemRepository.save(item);

        return converterParaDTO(atualizado);
    }

    // ---------------- DELETE ----------------
    public boolean deletar(Long listaId, Long id) {

        Item item = itemRepository.findById(id)
                .orElse(null);

        if (item == null || !item.getLista().getId().equals(listaId)) {
            return false;
        }

        itemRepository.delete(item);
        return true;
    }

    // ---------------- CONVERTER ----------------
    private ItemResponseDTO converterParaDTO(Item item) {

        ItemResponseDTO dto = new ItemResponseDTO();

        dto.setId(item.getId());
        dto.setNome(item.getNome());
        dto.setDescricao(item.getDescricao());
        dto.setPreco(item.getPreco());
        dto.setQuantidade(item.getQuantidade());
        dto.setComprado(item.getComprado());
        dto.setListaId(item.getLista().getId());

        if (item.getCategoria() != null) {
            dto.setCategoriaId(item.getCategoria().getId());
        }

        return dto;
    }
}