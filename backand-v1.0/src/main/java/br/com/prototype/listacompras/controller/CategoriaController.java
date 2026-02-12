package br.com.prototype.listacompras.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import br.com.prototype.listacompras.model.Categoria;
import br.com.prototype.listacompras.service.CategoriaService;

import java.util.List;

@RestController
@RequestMapping("/categorias")
public class CategoriaController {

	@Autowired
	private CategoriaService categoriaService;

	@PostMapping
	public ResponseEntity<Categoria> criarCategoria(@RequestBody Categoria categoria) {
		Categoria nova = categoriaService.criar(categoria);
		return ResponseEntity.ok(nova);
	}

	@GetMapping
	public List<Categoria> listarCategorias() {
		return categoriaService.listarTodos();
	}

	@GetMapping("/{id}")
	public ResponseEntity<Categoria> buscarCategoria(@PathVariable Long id) {
		return categoriaService.buscarPorId(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
	}

	@PutMapping("/{id}")
	public ResponseEntity<Categoria> atualizarCategoria(@PathVariable Long id,
			@RequestBody Categoria categoriaAtualizada) {
		Categoria atualizada = categoriaService.atualizar(id, categoriaAtualizada);
		return atualizada != null ? ResponseEntity.ok(atualizada) : ResponseEntity.notFound().build();
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Void> deletarCategoria(@PathVariable Long id) {
		boolean deletado = categoriaService.deletar(id);
		return deletado ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
	}
}
