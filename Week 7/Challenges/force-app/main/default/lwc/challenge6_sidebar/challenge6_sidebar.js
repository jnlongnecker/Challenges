import { LightningElement, wire } from 'lwc';

import bandChannel from '@salesforce/messageChannel/bandChannel__c';
import { subscribe, MessageContext } from 'lightning/messageService';

export default class Challenge6_sidebar extends LightningElement {
    @wire(MessageContext)
    context;

    band;

    connectedCallback() {
        this.subscription = subscribe(
            this.context, bandChannel, (message) => this.handleMessage(message)
        );
    }

    handleMessage(message) {
        this.band = message;
    }
}