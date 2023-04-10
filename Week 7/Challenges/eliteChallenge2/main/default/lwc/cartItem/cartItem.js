import { LightningElement, api } from 'lwc';
import updateCartItem from '@salesforce/apex/ShoppingCartController.updateCartItem';

import LightningAlert from 'lightning/alert';
export default class CartItem extends LightningElement {

    _item;

    @api
    get item() {
        return this._item;
    }

    set item(value) {
        this._item = value;
    }

    get isChecked() {
        return this.item.Status__c === 'Bought';
    }

    get containerClass() {
        const cls = 'slds-p-around_medium container';
        return this.isChecked ? cls + ' checked' : cls;
    }

    async alternateCheck() {
        try {
            let newItem = { ...this._item };
            if (this.isChecked) {
                newItem.Status__c = 'Searching';
            }
            else {
                newItem.Status__c = 'Bought';
            }
            this._item = await updateCartItem({ cartItemJson: JSON.stringify(newItem) });
            this.dispatchEvent(new CustomEvent('itemchange'));
        }
        catch (e) {
            const msg = e.body.message;
            LightningAlert.open({
                message: msg,
                theme: 'error',
                label: 'There was an error :(',
            });
        }
    }
}