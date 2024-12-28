package product;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, Integer> products; // Product ID -> Quantity

    public Cart() {
        products = new HashMap<>();
    }

    public void addProduct(int productId, int quantity) {
        products.put(productId, products.getOrDefault(productId, 0) + quantity);
    }

    public void updateProduct(int productId, int quantity) {
        if (products.containsKey(productId)) {
            products.put(productId, quantity);
        }
    }

    public void removeProduct(int productId) {
        products.remove(productId);
    }

    public Map<Integer, Integer> getProducts() {
        return products;
    }

    public void clear() {
        products.clear();
    }
}
