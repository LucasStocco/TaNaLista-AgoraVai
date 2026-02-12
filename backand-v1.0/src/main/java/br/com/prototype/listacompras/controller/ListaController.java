package br.com.prototype.listacompras.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import br.com.prototype.listacompras.model.Lista;
import br.com.prototype.listacompras.service.ListaService;

import java.util.List;

@RestController
@RequestMapping("/listas")
public class ListaController {

    @Autowired
    private ListaService listaService;

    @PostMapping
    public ResponseEntity<Lista> criarLista(@RequestBody Lista lista) {
        Lista nova = listaService.criar(lista);
        return ResponseEntity.ok(nova);
    }

    @GetMapping
    public List<Lista> listarListas() {
        return listaService.listarTodas();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Lista> buscarLista(@PathVariable Long id) {
        return listaService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Lista> atualizarLista(@PathVariable Long id, @RequestBody Lista listaAtualizada) {
        Lista atualizada = listaService.atualizar(id, listaAtualizada);
        return atualizada != null ? ResponseEntity.ok(atualizada) : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarLista(@PathVariable Long id) {
        boolean deletado = listaService.deletar(id);
        return deletado ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
    }
}
