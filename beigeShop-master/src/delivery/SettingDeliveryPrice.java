package delivery;

public class SettingDeliveryPrice {

    private final int delivery;

    public SettingDeliveryPrice(int delivery) {

        if (delivery < 100000){
            this.delivery = 3000;
        } else {
            this.delivery = 0;
        }
    }

    public int getDelivery() {
        return this.delivery;
    }
}
