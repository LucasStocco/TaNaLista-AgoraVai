package br.com.prototype.listacompras.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.prototype.listacompras.model.Lista;
import br.com.prototype.listacompras.repository.ListaRepository;
import br.com.prototype.listacompras.dto.ListaRequestDTO;
import br.com.prototype.listacompras.dto.ListaResponseDTO;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ListaService {

    @Autowired
    private ListaRepository listaRepository;

    // LISTAR TODAS
    public List<ListaResponseDTO> listarTodas() {
        return listaRepository.findAll()
                .stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    // BUSCAR POR ID
    public Optional<ListaResponseDTO> buscarPorId(Long id) {
        return listaRepository.findById(id)
                .map(this::toResponseDTO);
    }

    // CRIAR
    public ListaResponseDTO criar(ListaRequestDTO dto) {
        Lista lista = new Lista();
        lista.setNome(dto.getNome());

        Lista salva = listaRepository.save(lista);

        return toResponseDTO(salva);
    }

    // ATUALIZAR
    public ListaResponseDTO atualizar(Long id, ListaRequestDTO dto) {
        return listaRepository.findById(id)
                .map(lista -> {
                    lista.setNome(dto.getNome());
                    Lista atualizada = listaRepository.save(lista);
                    return toResponseDTO(atualizada);
                }).orElse(null);
    }

    // DELETAR
    public boolean deletar(Long id) {
        return listaRepository.findById(id)
                .map(lista -> {
                    listaRepository.delete(lista);
                    return true;
                }).orElse(false);
    }

    // MÉTODO AUXILIAR DE CONVERSÃO
    private ListaResponseDTO toResponseDTO(Lista lista) {
        return new ListaResponseDTO(
                lista.getId(),
                lista.getNome(),
                lista.getDataCriacao()
        );
    }
}