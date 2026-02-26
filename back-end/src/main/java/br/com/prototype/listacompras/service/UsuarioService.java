package br.com.prototype.listacompras.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.prototype.listacompras.model.Usuario;
import br.com.prototype.listacompras.repository.UsuarioRepository;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }

    public Optional<Usuario> buscarPorId(Long id) {
        return usuarioRepository.findById(id);
    }

    public Usuario criar(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    public Usuario atualizar(Long id, Usuario usuarioAtualizado) {
        return usuarioRepository.findById(id)
                .map(usuario -> {
                    usuario.setNome(usuarioAtualizado.getNome());
                    usuario.setEmail(usuarioAtualizado.getEmail());
                    usuario.setSenha(usuarioAtualizado.getSenha());
                    return usuarioRepository.save(usuario);
                }).orElse(null);
    }

    public boolean deletar(Long id) {
        return usuarioRepository.findById(id)
                .map(usuario -> {
                    usuarioRepository.delete(usuario);
                    return true;
                }).orElse(false);
    }

    public Usuario registrar(Usuario usuario) {

    // Validar campos obrigatórios
    if (usuario.getNome() == null || usuario.getNome().isEmpty()) {
        throw new RuntimeException("Nome é obrigatório");
    }

    if (usuario.getEmail() == null || usuario.getEmail().isEmpty()) {
        throw new RuntimeException("Email é obrigatório");
    }

    if (usuario.getSenha() == null || usuario.getSenha().isEmpty()) {
        throw new RuntimeException("Senha é obrigatória");
    }

    // Verificar se já existe email
    if (usuarioRepository.existsByEmail(usuario.getEmail())) {
        throw new RuntimeException("Email já cadastrado");
    }

    // Salvar usuário
    return usuarioRepository.save(usuario);
}

}
