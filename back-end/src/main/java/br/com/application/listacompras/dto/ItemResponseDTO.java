package br.com.application.listacompras.dto;

public class ItemResponseDTO {

    private Long id;
    private Long produtoId;
    private Integer quantidade;
    private Boolean comprado;
    private Long listaId;

    // --- getters e setters ---

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getProdutoId() { return produtoId; }
    public void setProdutoId(Long produtoId) { this.produtoId = produtoId; }

    public Integer getQuantidade() { return quantidade; }
    public void setQuantidade(Integer quantidade) { this.quantidade = quantidade; }

    public Boolean getComprado() { return comprado; }
    public void setComprado(Boolean comprado) { this.comprado = comprado; }

    public Long getListaId() { return listaId; }
    public void setListaId(Long listaId) { this.listaId = listaId; }
}