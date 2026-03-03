package br.com.prototype.listacompras.dto;

import java.math.BigDecimal;

public class ItemResponseDTO {

    private Long id;
    public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public BigDecimal getPreco() {
		return preco;
	}
	public void setPreco(BigDecimal preco) {
		this.preco = preco;
	}
	public Integer getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(Integer quantidade) {
		this.quantidade = quantidade;
	}
	public Boolean getComprado() {
		return comprado;
	}
	public void setComprado(Boolean comprado) {
		this.comprado = comprado;
	}
	public Long getListaId() {
		return listaId;
	}
	public void setListaId(Long listaId) {
		this.listaId = listaId;
	}
	public Long getCategoriaId() {
		return categoriaId;
	}
	public void setCategoriaId(Long categoriaId) {
		this.categoriaId = categoriaId;
	}
	private String nome;
    private String descricao;
    private BigDecimal preco;
    private Integer quantidade;
    private Boolean comprado;
    private Long listaId;
    private Long categoriaId;

}