public class OrderTriggerHelper {
  // Necessary if Order does not have a pricebook set
  public static void setDefaultPricebook(List<Order> newOrders) {
    Pricebook2 standardPricebook = [
      SELECT Id
      FROM Pricebook2
      WHERE IsStandard = TRUE
    ];
    for (Order order : newOrders) {
      if (order.Pricebook2Id == null) {
        order.Pricebook2Id = standardPricebook.Id;
      }
    }
  }

  // Orders can't be inserted with products already associated with them
  public static void addPortableProductToNewOrders(List<Order> newOrders) {
    PricebookEntry productEntry = [
      SELECT UnitPrice, Pricebook2Id, Product2Id
      FROM PricebookEntry
      WHERE
        Pricebook2.IsStandard = TRUE
        AND Product2.Name = 'Installation: Portable'
    ];

    List<OrderItem> newOrderProducts = new List<OrderItem>();

    // Add the order item for each new order
    for (Order order : newOrders) {
      OrderItem newItem = new OrderItem(
        Product2Id = productEntry.Product2Id,
        OrderId = order.Id,
        PricebookEntryId = productEntry.Id,
        UnitPrice = productEntry.UnitPrice,
        Quantity = 1
      );
      newOrderProducts.add(newItem);
    }

    insert newOrderProducts;
  }
}
