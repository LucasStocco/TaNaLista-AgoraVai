package br.com.prototype.listacompras.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.prototype.listacompras.model.Lista;
import br.com.prototype.listacompras.repository.ListaRepository;

import java.util.List;
import java.util.Optional;

@Service
public class ListaService {

    @Autowired
    private ListaRepository listaRepository;

    public List<Lista> listarTodas() {
        return listaRepository.findAll();
    }

    public Optional<Lista> buscarPorId(Long id) {
        return listaRepository.findById(id);
    }

    public Lista criar(Lista lista) {
        return listaRepository.save(lista);
    }

    public Lista atualizar(Long id, Lista listaAtualizada) {
        return listaRepository.findById(id)
                .map(lista -> {
                    lista.setNome(listaAtualizada.getNome());
                    lista.setDataCriacao(listaAtualizada.getDataCriacao());
                    return listaRepository.save(lista);
                }).orElse(null);
    }

    public boolean deletar(Long id) {
        return listaRepository.findById(id)
                .map(lista -> {
                    listaRepository.delete(lista);
                    return true;
                }).orElse(false);
    }
}
