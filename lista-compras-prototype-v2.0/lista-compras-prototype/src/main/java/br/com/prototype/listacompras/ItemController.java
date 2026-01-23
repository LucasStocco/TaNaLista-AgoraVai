package br.com.prototype.listacompras;

import br.com.prototype.listacomprasprototype.model.Item;
import br.com.prototype.listacompras.repository.ItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/itens") // Base dos endpoints
public class ItemController {

    @Autowired
    private ItemRepository itemRepository;

    // ----------------- CREATE -----------------
    @PostMapping
    public Item criarItem(@RequestBody Item item) {
        return itemRepository.save(item);
    }

    // ----------------- READ ALL -----------------
    @GetMapping
    public List<Item> listarItens() {
        return itemRepository.findAll();
    }

    // ----------------- READ ONE -----------------
    @GetMapping("/{id}")
    public ResponseEntity<Item> buscarItem(@PathVariable Long id) {
        Optional<Item> item = itemRepository.findById(id);
        return item.map(ResponseEntity::ok)
                   .orElse(ResponseEntity.notFound().build());
    }

    // ----------------- UPDATE -----------------
    @PutMapping("/{id}")
    public ResponseEntity<Item> atualizarItem(@PathVariable Long id, @RequestBody Item itemAtualizado) {
        return itemRepository.findById(id).map(item -> {
            item.setNome(itemAtualizado.getNome());
            item.setQuantidade(itemAtualizado.getQuantidade());
            item.setPreco(itemAtualizado.getPreco());
            item.setDescricao(itemAtualizado.getDescricao());
            Item itemSalvo = itemRepository.save(item);
            return ResponseEntity.ok(itemSalvo);
        }).orElse(ResponseEntity.notFound().build());
    }

    // ----------------- DELETE -----------------
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarItem(@PathVariable Long id) {
        return itemRepository.findById(id).map(item -> {
            itemRepository.delete(item);
            return ResponseEntity.noContent().<Void>build();
        }).orElse(ResponseEntity.notFound().build());
    }
}
