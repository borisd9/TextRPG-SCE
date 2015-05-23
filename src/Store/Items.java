package Store;
/**
 * Items implementation class 
 *  represent item object that in our store-coins
 */
public class Items {
    private int price;
    private String itemDescription;
    private int coin;
    private int Quantity;
    private int totalCoins;
    private int totalPrice;
    
    public int getPrice() {
        return price;
    }
    public void setPrice(int price) {
        this.price = price;
    }
    public String getitemDescription() {
        return itemDescription;
    }
    public void setDescription(String description) {
        this.itemDescription = description;
    }
    public int getUnitCoin() {
        return coin;
    }
    public void setUnitCost(int coin) {
        this.coin = coin;
    }
    public int getQuantity() {
        return Quantity;
    }
    public void setQuantity(int quantity) {
        Quantity = quantity;
    }
    public int getTotalCoins() {
        return totalCoins;
    }
    public int getTotalPrice()
    {
    	return totalPrice;
    }
    public void setTotalCost(int total,int totalPrice) {
        this.totalCoins = total;
        this.totalPrice=totalPrice;
    }
}