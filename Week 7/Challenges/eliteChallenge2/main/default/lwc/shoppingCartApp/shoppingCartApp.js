import { LightningElement, wire } from 'lwc';
import LightningAlert from 'lightning/alert';

import { refreshApex } from '@salesforce/apex';
import getContextCartItems from '@salesforce/apex/ShoppingCartController.getContextCartItems';
import createCartItem from '@salesforce/apex/ShoppingCartController.createCartItem';

export default class ShoppingCartApp extends LightningElement {

    cachedInfo;

    cartItemInfo;

    @wire(getContextCartItems)
    parseCartItemInfo(value) {
        this.cachedInfo = value;
        const { data, error } = value;
        if (data) {
            this.cartItemInfo = data;
            console.log(JSON.stringify(data));
        }
        if (error) {
            LightningAlert.open({
                message: error.message,
                theme: 'error',
                label: 'There was an error :(',
            });
        }
    }

    get username() {
        if (!this.cartItemInfo) return '';
        return this.cartItemInfo.username;
    }

    get cardWelcomeText() {
        if (!this.cartItemInfo) return 'Welcome!';
        if (!this.cartItemInfo.items.length) return 'Welcome ' + this.username + '!';
        return `Welcome Back, ${this.username}!`;
    }

    get cartItems() {
        if (!this.cartItemInfo) return [];
        let cartCopy = [...this.cartItemInfo.items];
        cartCopy.sort((a, b) => {
            if (a.Status__c === 'Bought') return 1;
            if (b.Status__c === 'Bought') return -1;
            return 0;
        });
        return cartCopy;
    }

    clearInput() {
        this.refs.input.value = '';
        this.refs.quantity.value = 1;
    }

    async addItem() {
        let quantity = this.refs.quantity.value;
        let name = this.refs.input.value;
        const newItem = {
            Name: name,
            Quantity__c: quantity,
            Status__c: 'Searching',
        }
        await createCartItem({ cartItemJson: JSON.stringify(newItem) });
        refreshApex(this.cachedInfo);
        this.clearInput();
    }

    handleChange() {
        refreshApex(this.cachedInfo);
    }
}