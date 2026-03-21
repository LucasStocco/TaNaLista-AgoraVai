package br.com.application.listacompras.dto;

import java.time.LocalDateTime;

public class ListaResponseDTO {

    private Long id;
    private String nome;
    private LocalDateTime dataCriacao;

    public ListaResponseDTO(Long id, String nome, LocalDateTime dataCriacao) {
        this.id = id;
        this.nome = nome;
        this.dataCriacao = dataCriacao;
    }

    public Long getId() { return id; }
    public String getNome() { return nome; }
    public LocalDateTime getDataCriacao() { return dataCriacao; }
}