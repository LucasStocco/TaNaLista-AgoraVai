package br.com.prototype.listacompras.model;

import java.math.BigDecimal;

public class Financeiro {
 public static interface GastoPorLista {
	String getNomeLista();
	BigDecimal getTotalGasto();
}

 public static interface GastoPorCategoria {
	String NomeCategoria();
	BigDecimal getTotalGasto();
} 
}