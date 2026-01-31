package br.com.prototype.listacompras.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.prototype.listacompras.model.Item;
import br.com.prototype.listacompras.model.Lista;
import br.com.prototype.listacompras.repository.ItemRepository;
import br.com.prototype.listacompras.repository.ListaRepository;

@Service
public class ItemService {

    @Autowired
    private ItemRepository itemRepository;

    @Autowired
    private ListaRepository listaRepository;

    // ---------------- CREATE ----------------
    public Item criar(Long listaId, Item item) {
        Lista lista = listaRepository.findById(listaId)
                .orElseThrow(() -> new RuntimeException("Lista não encontrada"));

        item.setLista(lista);
        return itemRepository.save(item);
    }

    // ---------------- READ ALL (POR LISTA) ----------------
    public List<Item> listarPorLista(Long listaId) {
        return itemRepository.findByListaId(listaId);
    }

    // ---------------- READ ONE ----------------
    public Item buscarPorId(Long listaId, Long itemId) {
        Optional<Item> itemOpt = itemRepository.findById(itemId);

        if (itemOpt.isEmpty()) {
            return null;
        }

        Item item = itemOpt.get();

        if (!item.getLista().getId().equals(listaId)) {
            return null;
        }

        return item;
    }

    // ---------------- UPDATE ----------------
    public Item atualizar(Long id, Item itemAtualizado) {
        return itemRepository.findById(id)
                .map(item -> {
                    item.setNome(itemAtualizado.getNome());
                    item.setDescricao(itemAtualizado.getDescricao());
                    item.setQuantidade(itemAtualizado.getQuantidade());
                    item.setPreco(itemAtualizado.getPreco());
                    return itemRepository.save(item);
                })
                .orElse(null);
    }

    // ---------------- DELETE ----------------
    public boolean deletar(Long id) {
        if (!itemRepository.existsById(id)) return false;
        itemRepository.deleteById(id);
        return true;
    }
}
