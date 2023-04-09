import { LightningElement, wire, api } from 'lwc';

import { getRecord } from 'lightning/uiRecordApi';
import CONTACT_NAME_FIELD from '@salesforce/schema/Contact.Name';
import CONTACT_PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import CONTACT_EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import CONTACT_TITLE_FIELD from '@salesforce/schema/Contact.Title';

const FIELDS = [
    CONTACT_EMAIL_FIELD,
    CONTACT_NAME_FIELD,
    CONTACT_PHONE_FIELD,
    CONTACT_TITLE_FIELD,
];

export default class Challenge8 extends LightningElement {

    @api
    recordId;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    contact;

    get name() {
        if (!this.contact.data) return '';
        return this.contact.data.fields.Name.value;
    }

    get phone() {
        if (!this.contact.data) return '';
        return this.contact.data.fields.Phone.value;
    }

    get email() {
        if (!this.contact.data) return '';
        return this.contact.data.fields.Email.value;
    }

    get title() {
        if (!this.contact.data) return '';
        return this.contact.data.fields.Title.value;
    }
}