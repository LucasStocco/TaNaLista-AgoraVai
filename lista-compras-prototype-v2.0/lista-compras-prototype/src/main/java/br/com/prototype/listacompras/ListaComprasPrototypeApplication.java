package br.com.prototype.listacompras;

import br.com.prototype.listacomprasprototype.model.Item;
import br.com.prototype.listacompras.repository.ItemRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
// Indica para o Spring escanear entidades JPA fora do pacote base
@EntityScan(basePackages = "br.com.prototype.listacomprasprototype.model")
public class ListaComprasPrototypeApplication {

    public static void main(String[] args) {
        SpringApplication.run(ListaComprasPrototypeApplication.class, args);
    }

    // CommandLineRunner para adicionar itens no banco na inicialização
    @Bean
    public CommandLineRunner run(ItemRepository itemRepository) {
        return args -> {
            Item item = new Item();
            item.setNome("Leite");
            item.setQuantidade(2);
            item.setPreco(5.50);
            item.setDescricao("Leite integral 1L");

            itemRepository.save(item);

            System.out.println("Itens cadastrados:");
            itemRepository.findAll().forEach(System.out::println);
        };
    }
}
