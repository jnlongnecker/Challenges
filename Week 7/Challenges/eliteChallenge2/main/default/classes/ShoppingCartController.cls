public with sharing class ShoppingCartController {
  @AuraEnabled(cacheable=true)
  public static ShoppingCartInfo getContextCartItems() {
    if (!Schema.SObjectType.CartItem__c.isAccessible()) {
      throw new AuraHandledException(
        'Error: You do not have permission to view cart items.'
      );
    }

    Id userId = UserInfo.getUserId();
    ShoppingCartInfo returnInfo = new ShoppingCartInfo();
    returnInfo.username = UserInfo.getName();
    returnInfo.items = [
      SELECT Name, Quantity__c, Status__c
      FROM CartItem__c
      WHERE Owner.Id = :userId
    ];

    return returnInfo;
  }

  @AuraEnabled
  public static CartItem__c createCartItem(String cartItemJson) {
    if (!Schema.SObjectType.CartItem__c.isCreateable()) {
      throw new AuraHandledException(
        'Error: You do not have permission to create cart items.'
      );
    }
    CartItem__c newItem = (CartItem__c) JSON.deserializeStrict(
      cartItemJson,
      CartItem__c.class
    );
    insert newItem;
    return newItem;
  }

  @AuraEnabled
  public static CartItem__c updateCartItem(String cartItemJson) {
    if (!Schema.SObjectType.CartItem__c.isUpdateable()) {
      throw new AuraHandledException(
        'Error: You do not have permission to update cart items.'
      );
    }
    try {
      CartItem__c newItem = (CartItem__c) JSON.deserializeStrict(
        cartItemJson,
        CartItem__c.class
      );
      update newItem;
      return newItem;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  public class ShoppingCartInfo {
    @AuraEnabled
    public String username;
    @AuraEnabled
    public List<CartItem__c> items;
  }
}