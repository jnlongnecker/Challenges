import { LightningElement, api, wire } from 'lwc';

import bandChannel from '@salesforce/messageChannel/bandChannel__c';
import { publish, MessageContext } from 'lightning/messageService';

export default class Challenge6_child extends LightningElement {

    @api
    band;

    @wire(MessageContext)
    context;

    sendBand() {
        const message = JSON.parse(JSON.stringify(this.band));
        publish(this.context, bandChannel, message);
    }
}