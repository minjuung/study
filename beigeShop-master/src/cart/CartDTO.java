package cart;

public class CartDTO {
    private String productImage; //상품이미지
    private int productInfo;  //상품정보
    private int price;           //가격
    private String delivery;     //배송종류
    private String deliveryPrice;//배송비용

    private int shopId;
    private String shopName;
    private String shopImage;
    private String shopCategory;
    private int shopPrice;
    private int shopStock;
    private String shopSize;

    private String mId;
    private int sId;
    private int cAmount;
    private String sType;
    private int sPrice;
    private String cDate;
    
    public CartDTO(String mId, int sId, int cAmount) {
        this.mId = mId;
        this.sId = sId;
        this.cAmount = cAmount;
    }

    public CartDTO(String mId, int sId, int cAmount, String sType, int sPrice, String cDate) {
        this.mId = mId;
        this.sId = sId;
        this.cAmount = cAmount;
        this.sType = sType;
        this.sPrice = sPrice;
        this.cDate = cDate;
    }


    public String getmId() {
        return mId;
    }

    public int getsId() {
        return sId;
    }

    public int getcAmount() {
        return cAmount;
    }

    public String getsType() {
        return sType;
    }

    public int getsPrice() {
        return sPrice;
    }

    public String getcDate() {
        return cDate;
    }

    public CartDTO() {
    }



    public CartDTO(int shopId, String shopName, String shopImage, String shopCategory, int shopPrice, int shopStock, String shopSize) {
        this.shopId = shopId;
        this.shopName = shopName;
        this.shopImage = shopImage;
        this.shopCategory = shopCategory;
        this.shopPrice = shopPrice;
        this.shopStock = shopStock;
        this.shopSize = shopSize;
    }

    public CartDTO(String productImage, int productInfo, int price, String delivery, String deliveryPrice) {
        this.productImage = productImage;
        this.productInfo = productInfo;
        this.price = price;
        this.delivery = delivery;
        this.deliveryPrice = deliveryPrice;
    }


    public int getShopId() {
        return shopId;
    }

    public String getShopName() {
        return shopName;
    }

    public String getShopImage() {
        return shopImage;
    }

    public String getShopCategory() {
        return shopCategory;
    }

    public int getShopPrice() {
        return shopPrice;
    }

    public int getShopStock() {
        return shopStock;
    }

    public String getShopSize() {
        return shopSize;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public int getProductInfo() {
        return productInfo;
    }

    public void setProductInfo(int productInfo) {
        this.productInfo = productInfo;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getDelivery() {
        return delivery;
    }

    public void setDelivery(String delivery) {
        this.delivery = delivery;
    }

    public String getDeliveryPrice() {
        return deliveryPrice;
    }

    public void setDeliveryPrice(String deliveryPrice) {
        this.deliveryPrice = deliveryPrice;
    }
}
