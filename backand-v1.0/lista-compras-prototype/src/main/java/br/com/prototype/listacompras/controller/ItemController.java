package br.com.prototype.listacompras.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import br.com.prototype.listacompras.model.Item;
import br.com.prototype.listacompras.service.ItemService;

@RestController
@RequestMapping("/listas/{listaId}/itens")
public class ItemController {

    @Autowired
    private ItemService itemService;

    // CREATE
    @PostMapping
    public ResponseEntity<Item> criarItem(
            @PathVariable Long listaId,
            @RequestBody Item item
    ) {
        Item novoItem = itemService.criar(listaId, item);
        return ResponseEntity.ok(novoItem);
    }

    // READ ALL (por lista)
    @GetMapping
    public List<Item> listarItens(@PathVariable Long listaId) {
        return itemService.listarPorLista(listaId);
    }

    // READ ONE
    @GetMapping("/{id}")
    public ResponseEntity<Item> buscarPorId(
            @PathVariable Long listaId,
            @PathVariable Long id
    ) {
        Item item = itemService.buscarPorId(listaId, id);
        return item != null
                ? ResponseEntity.ok(item)
                : ResponseEntity.notFound().build();
    }

    // UPDATE
    @PutMapping("/{id}")
    public ResponseEntity<Item> atualizarItem(
            @PathVariable Long listaId,
            @PathVariable Long id,
            @RequestBody Item itemAtualizado
    ) {
        Item atualizado = itemService.atualizar(id, itemAtualizado);
        return atualizado != null
                ? ResponseEntity.ok(atualizado)
                : ResponseEntity.notFound().build();
    }

    // DELETE
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarItem(
            @PathVariable Long listaId,
            @PathVariable Long id
    ) {
        boolean deletado = itemService.deletar(id);

        return deletado
                ? ResponseEntity.noContent().build()
                : ResponseEntity.notFound().build();
    }
}
