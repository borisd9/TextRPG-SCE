package Store;
/**
 * Items implementation class 
 *  represent item object from Database
 */
public class Items {
    private String itemNum;
    private String itemDescription;
    private double price;
    private int Quantity;
    private double total;
     
    public String getPartNumber() {
        return itemNum;
    }
    public void setPartNumber(String itemNum) {
        this.itemNum = itemNum;
    }
    public String getitemDescription() {
        return itemDescription;
    }
    public void setDescription(String description) {
        this.itemDescription = description;
    }
    public double getUnitCost() {
        return price;
    }
    public void setUnitCost(double price) {
        this.price = price;
    }
    public int getQuantity() {
        return Quantity;
    }
    public void setQuantity(int quantity) {
        Quantity = quantity;
    }
    public double getTotalCost() {
        return total;
    }
    public void setTotalCost(double total) {
        this.total = total;
    }
}